"""
Demonstrates the benefits of using generics.
"""
from typing import Any, Generic, List, TypeVar

import pytest

AnyT = TypeVar("AnyT", bound=Any)


class AnyList:
    """
    A very rudimentary list that can hold any type of value.

    Probably best not to focus on the function implementation and the fact this
    uses a real list below the surface, the method signatures are the important
    part.
    """

    def __init__(self) -> None:
        self._items: List[Any] = []

    def add(self, item: Any) -> None:
        self._items.append(item)

    def get(self, index: int) -> Any:
        return self._items[index]


def test_simple() -> None:
    sl = AnyList()
    # I can add any value ...
    sl.add(1)
    # But once I retrieve it, the type is no longer known
    value = sl.get(0)
    # So mypy and VSCcode no longer knows when I use it in the wrong way

    # The type checker won't raise any problems with the code below, but it will
    # raise an TypeError at runtime:
    with pytest.raises(TypeError):
        value + "33"


class GenericList(Generic[AnyT]):
    """
    A very rudimentary generic list.

    Probably best not to focus on the function implementation and the fact this
    uses a real list below the surface, the method signatures are the important
    part.
    """

    def __init__(self) -> None:
        self._items: List[AnyT] = []

    def add(self, item: AnyT) -> None:
        self._items.append(item)

    def get(self, index: int) -> AnyT:
        return self._items[index]


def test_generic() -> None:
    """
    This demonstrates
    """
    gl = GenericList[int]()
    # I can add only int values ...
    gl.add(1)
    # And once I retrieve it, the type is still known
    value = gl.get(0)
    # So mypy and VSCcode knows when I use it in the wrong way

    # If I did: value + "33"
    # Mypy would raise an error: Unsupported operand types for + ("int" and "str")  [operator]

    # And of course correctly using it does not raise any errors
    value + 33
