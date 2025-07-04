"""Functions that provide reference bindings with explicit mutability in [Mojo](https://www.modular.com/mojo)."""

@always_inline
fn mut_[T: Copyable & Movable](mut value: T) -> ref [value] T:
    """Returns `value` as a mutable reference."""
    return value


@always_inline
fn read_[T: Copyable & Movable](read value: T) -> ref [value] T:
    """Returns `value` as an immutable reference."""
    return value


@always_inline
fn var_[T: Copyable & Movable](var value: T) -> T:
    """Returns `value`as an "owned" value (moves or copies `value`).

    Use `ref let_a = read_(ref(var_(value))` to create a runtime constant.
    """
    return value^
