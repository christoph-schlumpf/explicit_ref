"""Functions that provide reference bindings with explicit mutability in [Mojo](https://www.modular.com/mojo)."""


@always_inline
fn mut[T: Copyable & Movable](mut value: T) -> ref [value] T:
    """Returns `value` as a mutable reference."""
    return value


@always_inline
fn read[T: Copyable & Movable](read value: T) -> ref [value] T:
    """Returns `value` as an immutable reference."""
    return value


@always_inline
fn own[T: Copyable & Movable](owned value: T) -> T:
    """Returns `value`as an "owned" value (moves or copies `value`).

    Use `ref let_a = read_ref(own(value))` to create a runtime constant.
    """
    return value^
