import logging


from aucampia.eg.azure_ad_and_iam import package_function


def test_something() -> None:
    logging.info("entry: ...")
    assert package_function() == "value"


# ...
