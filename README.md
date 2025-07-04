# explicit_ref
<p align="center">
 <img src="./logo.jpeg" width=250px>
</p>
A tiny [Mojo](https://www.modular.com/mojo) package for references with explicit mutability.

```mojo
ref mut_value = mut_(value)
"""An explicit mutable reference.

`value` must be mutable or the code will not compile.
"""

ref read_value = read_(value)
"""An explicit immutable reference.

`read_value` can't be reassinged and `value` can't be mutated via `read_value`.
"""

ref let_value = read_(var_(value))
"""A runtime constant.

`let_value` can't be reassinged or mutated. No other variable can mutate this moved or copied `value`.

This is the same as `let` or `const` bindings in many other programming languages.
"""
```
See [example](./example.mojo).

Corresponding "syntactic sugar" for references with explicit mutability (not implemented as of Mojo 25.4 and might never be implemented):

```mojo
mut a = value
read b = value
let c = value # or `const d = value`
```

# Recommendations

Only use "explicit_ref" references to make the intended mutability explicit and enforce it. In many cases `var` and `ref` are sufficient.

For runtime constants, `ref a = read_(var_(value)))` can be simplified to `ref a = read_(value)` if `vakue` already is/returns a an "owned" value.

Prefer compile time `alias` declarations over runtime `read_(var_())` constants. It is more efficient and idiomatic Mojo.

```mojo
ref start_time = read_(time.perf_counter_ns())
""" Good: value is not known at compile time but shall not be mutated"""

alias magic_number = 42
"""Good: value is known at compile time"""

ref magic_number = read_(42)
"""Avoid: value is known at compile time. Use `alias`"""
```

# Motivation

Starting with Mojo 25.4 local variable bindings have been enhanced with `ref` and implicit `read` (see [Variable Bindings in Mojo](https://github.com/modular/modular/blob/main/mojo/proposals/variable-bindings.md)):

```mojo
var a = value
"""A local variable that "owns" `value` with mutable access."""

ref b = value
"""A local reference to `value` with inferred mutability.
The mutability of `b` is the same as the mutability of `value`.
"""

for var i in iterator:
"""A local variable to the `ìterator` values.
`i` "owns" the `ìterator` values with mutable access.
"""

for ref j in iterator:
"""A local reference to the `iterator` values with inferred mutability.
The mutability of `j` is the same as the mutability of the `ìterator` values.
"""

for k in iterator:
"""A local reference to the `iterator` values with implicit `read` access (immutable)."""
```

References with explicit mutability might be a good complement to the existing variable bindings in Mojo.

See discussion in the [Mojo community forum](https://forum.modular.com/t/the-case-for-explicit-read-variable-bindings/1604)
