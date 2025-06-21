# ===----------------------------------------------------------------------=== #
# Copyright (c) 2025, Christoph Schlumpf
#
# Licensed under the Apache License v2.0 with LLVM Exceptions:
# https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ===----------------------------------------------------------------------=== #
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
