#!/usr/bin/env bash

SCRIPT_DIR="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"

set -x -Eeuo pipefail

# https://github.com/search?q=lang%3APython+topic%3Acli&type=repositories&s=stars&o=desc
# https://github.com/search?q=lang%3APython+topic%3Acommand-line&type=repositories&s=stars&o=desc
# https://github.com/search?q=lang%3APython+topic%3Acommand-line-interface&type=repositories&s=stars&o=desc
PACKAGES=(
    black
    codespell
    cookiecutter
    copier
    cruft
    csvkit
    databricks-cli
    doit
    flake8
    gitsome
    httpie
    ipython
    jc
    jello
    jrnl
    mypy
    pgcli
    pip
    pip-tools
    pipenv
    pipx
    poetry
    pycln
    pylint
    pyshacl
    pytest
    pyupgrade
    rdflib
    sherlock
    tox
    virtualenv
    xonsh
    youtube-dl
    yq
)

echo "PACKAGES=${PACKAGES[*]}"

DESTINATION="var/wheels"

cd "${SCRIPT_DIR}"

# rm -rv /var/tmp/202309-python_apps/wheels
mkdir -vp "${DESTINATION}"

python3.11 -m pip download --no-deps --only-binary :all: --dest "${DESTINATION}" "${PACKAGES[@]}"

rm -rv "output"
mkdir -vp "output"

for WHEEL_PATH in "${DESTINATION}"/*.whl; do
    WHEEL_FILE="$(basename -- "${WHEEL_PATH}")"
    #wheel2json "${WHEEL_PATH}" | trdsql -ijq '.dist_info.metadata.requires_dist' -ocsv -oh 'SELECT "'"${WHEEL_FILE}"'" as wheel, name,specifier,url,extras,marker FROM stdin' > "${SCRIPT_DIR}/output/${WHEEL_FILE}.requires_dist.csv"
    wheel2json "${WHEEL_PATH}" |
        jq -ec '.dist_info.metadata.requires_dist[]' >"output/${WHEEL_FILE}.requires_dist.ndjson" || :
    wheel2json "${WHEEL_PATH}" |
        trdsql -ijq '.dist_info.metadata.requires_dist' -ocsv -oh 'SELECT name,specifier,url,extras,marker FROM stdin' >"output/${WHEEL_FILE}.requires_dist.csv" || :
done

jq -c '({ "wheel": (input_filename | match("^.*/([^/]+).requires_dist.ndjson$")).captures[0].string } + .)' output/*.ndjson >output/combined.ndjson
cat output/combined.ndjson |
    trdsql -ijson -ocsv -oh 'SELECT wheel,name,specifier,url,extras,marker FROM STDIN ORDER BY wheel, name;' >output/combined.csv

jq '. | select(.specifier | test("==|<"))' output/combined.ndjson >output/restricted.ndjson
cat output/restricted.ndjson |
    trdsql -ijson -ocsv -oh 'SELECT wheel,name,specifier,url,extras,marker FROM STDIN ORDER BY wheel, name;' >output/restricted.csv
