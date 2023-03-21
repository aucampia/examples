import abc
from dataclasses import dataclass
from typing import Generic, TypeVar


class Shape(abc.ABC):
    @abc.abstractmethod
    def get_area(self) -> float:
        ...


@dataclass
class Square(Shape):
    length: float

    def get_area(self) -> float:
        return self.length**2


@dataclass
class Circle(Shape):
    radius: float

    def get_area(self) -> float:
        return self.radius**2 * 3.14


ShapeAT = TypeVar("ShapeAT", bound=Shape)
ShapeBT = TypeVar("ShapeBT", bound=Shape)


@dataclass
class GenericShapePair(Generic[ShapeAT, ShapeBT]):
    shape1: ShapeAT
    shape2: ShapeBT


def generic_pair_area(pair: GenericShapePair[Shape, Shape]) -> float:
    return pair.shape1.get_area() + pair.shape2.get_area()


def test_generic() -> None:
    pair: GenericShapePair[Square, Circle] = GenericShapePair(Square(2), Circle(3))
    # It would be reasonable to expect this value to be usable with `generic_pair_area`, but mypy thinks it should not work
    # 👇 mypy error: Argument 1 to "generic_pair_area" has incompatible type "GenericShapePair[Square, Circle]"; expected "GenericShapePair[Shape, Shape]"
    assert generic_pair_area(pair) == 13.14

    # The reason for this is because by default, type variables are invariant.

    # For invariant type variables, the relationship the specific types are not
    # considered by the type checker. So even though Square and Circle are
    # shapes, and generic_pair_area accepts any pair of shapes, the type checker
    # will not allow it because it does not look at the relationship between the
    # types inside the generic shape pair.


ShapeAT_co = TypeVar("ShapeAT_co", bound=Shape, covariant=True)
ShapeBT_co = TypeVar("ShapeBT_co", bound=Shape, covariant=True)


@dataclass
class GenericCovariantShapePair(Generic[ShapeAT_co, ShapeBT_co]):
    shape1: ShapeAT_co
    shape2: ShapeBT_co


def generic_covariant_shape_area(
    pair: GenericCovariantShapePair[Shape, Shape]
) -> float:
    return pair.shape1.get_area() + pair.shape2.get_area()


def test_generic_covariant() -> None:
    pair: GenericCovariantShapePair[Square, Circle] = GenericCovariantShapePair(
        Square(2), Circle(3)
    )
    # Doing the exact same thing with covariant type variables works as expected
    # with no mypy errors, because now GenericCovariantShapePair[Square, Circle] is a subtype of GenericCovariantShapePair[Shape, Shape].
    assert generic_covariant_shape_area(pair) == 13.14
