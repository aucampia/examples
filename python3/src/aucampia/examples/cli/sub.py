#!/usr/bin/env python3
import logging
from typing import List, Optional

import typer

logger = logging.getLogger(__name__)

"""
https://click.palletsprojects.com/en/7.x/api/#parameters
https://click.palletsprojects.com/en/7.x/options/
https://click.palletsprojects.com/en/7.x/arguments/
https://typer.tiangolo.com/
https://typer.tiangolo.com/tutorial/options/
"""


cli_sub = typer.Typer()


@cli_sub.callback()
def cli_sub_callback(ctx: typer.Context) -> None:
    logger.debug(
        "entry: ctx_parent_params = %s, ctx_params = %s",
        ({} if ctx.parent is None else ctx.parent.params),
        ctx.params,
    )


@cli_sub.command("leaf")
def cli_sub_leaf(
    ctx: typer.Context,
    name: Optional[str] = typer.Option("fake", "--name", "-n", help="The name ..."),
    numbers: Optional[List[int]] = typer.Argument(None),
) -> None:
    logger.debug(
        "entry: ctx_parent_params = %s, ctx_params = %s",
        ({} if ctx.parent is None else ctx.parent.params),
        ctx.params,
    )
