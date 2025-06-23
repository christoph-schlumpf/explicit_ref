# explicit_ref
<p align="center">
 <img src="./logo.jpeg" width=200px>
</p>
A tiny module that provides reference bindings with explicit mutability in [Mojo](https://www.modular.com/mojo):

```mojo
ref mut_value = mut(value)
"""An explicit mutable reference binding to `value`.

`value` must be mutable or the code will not compile.
"""

ref read_value = read(value)
"""An explicit immutable reference binding to `value`.

`read_value` can't be reassinged and `value` can't be mutated via `read_value`.
"""

ref let_value = read(own(value))
"""A runtime constant binding to a moved or copied `value`.

`let_value` can't be reassinged or mutated. No other variable can mutate this moved or copied `value`.

This is the same as `let` or `const` bindings in many other programming languages.
"""
```
See [example](./example.mojo).

Corresponding "syntactic sugar" for reference bindings with explicit mutability (not implemented as of Mojo 25.4 and might never be implemented):

```mojo
mut a = value
read b = value
let c = value # or `const d = value`
```

# Recommendations

Only use "explicit_ref" reference bindings to make the intended mutability explicit and enforce it. In many cases `var` and `ref` are sufficient.

For runtime constants, `read(own(a_function())))` can be simplified to `read(a_function()))` if `a_function()` already returns a an "owned" value.

Prefer compile time `alias` declarations over runtime `read(own())` constant bindings. It is more efficient and idiomatic Mojo.

```mojo
ref startTime = read(time.perf_counter_ns())
""" Good: value is not known at compile time but shall not be mutated"""

alias magic_number = 42
"""Good: value is known at compile time"""

ref magic_number = read(42)
"""Avoid: value is known at compile time. Use `alias`"""
```

# Motivation

Starting with Mojo 25.4 local variable bindings have been enhanced with `ref` bindings and implicit `read` bindings (see [Variable Bindings in Mojo](https://github.com/modular/modular/blob/main/mojo/proposals/variable-bindings.md)):

```mojo
var a = value
"""A local variable binding that "owns" `value` with mutable access."""

ref b = value
"""A local reference binding to `value` with inferred mutability.
The mutability of `b` is the same as the mutability of `value`.
"""

for var i in iterator:
"""A local variable binding to the `ìterator` values.
`i` "owns" the `ìterator` values with mutable access.
"""

for ref j in iterator:
"""A local reference binding to the `iterator` values with inferred mutability.
The mutability of `j` is the same as the mutability of the `ìterator` values.
"""

for k in iterator:
"""A local reference binding to the `iterator` values with implicit `read` access (immutable)."""
```

Reference bindings with explicit mutability might be a good complement to the existing variable bindings in Mojo.
