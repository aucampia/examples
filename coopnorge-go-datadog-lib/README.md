# ...


```bash
go get -u ./...
go mod tidy
go mod graph | grep echo
mkdir -vp var/
go build -o var/
ls -lh var/example-coopnorge-go-datadog-lib
strings var/example-coopnorge-go-datadog-lib | grep echo
```

```console

```
