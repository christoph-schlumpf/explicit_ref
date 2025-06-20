# explicit_ref

A tiny library that provides reference bindings with explicit mutability in [Mojo](https://www.modular.com/mojo):

```mojo
ref a = mut_ref(value)
"""An explicit mutable reference binding to `value`.
`value` must be mutable or the code will not compile.
"""

ref b = read_ref(value)
"""An explicit `read` reference binding (immutable).
`b` can't be reassinged an the `value` can't be mutated via `b`.
"""

ref c = let_ref(value)
"""An exclusive immutable reference binding to `value`.
`c` can't be reassinged an the `value` can't be mutated via `a`.
No other variable can access `value`.
This is the same as `let` and `const` in many other programming languages (i.e. a runtime constant).
"""

# or
ref d = const_ref(value)
"""An alternative to `let` because some prefer to call it `const`."""
```

Possible corresponding "syntactic sugar" for reference bindings with explicit mutability (not implemented as of Mojo 25.4 and might never be implemented):
```mojo
mut a = value
read b = value
let c = value
# or
const d = value
```

# Recommendations

Only use "explicit_ref" reference bindings if needed to make the intended mutability explicit and enforce it. In many cases `var` and `ref` are sufficient.

Prefer compile time `alias` declarations to runtime `let_ref()`/`const_ref)()` constant bindings. It is more efficient and idiomatic in Mojo.

```mojo
ref startTime = time.perf_counter_ns()
""" Good: value is not known at complie time but shall not be mutated"""

alias magic_number = 42` 
"""Good: value is known at compile time)"""

ref magic_number = let_ref(42)
"""Avoid: value is known at compile time. Use `alias` instead"""
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
