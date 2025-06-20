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
from explicit_ref import mut_ref, read_ref
from time import *


fn main() raises:
    ref let_start_time = read_ref(time.perf_counter_ns())

    # ref mut_start_time = mut_ref(let_start_time) # error: startTime is immutable

    # let_start_time += 1 # error: let_start_time is immutable

    print("let_start_time =", let_start_time)

    var interim_time = time.perf_counter_ns()
    ref mut_interim_time = mut_ref(interim_time)
    ref read_interim_time = read_ref(interim_time)
    ref let_interim_time = read_ref(interim_time.copy())

    mut_interim_time = 0  # This mutates interim_time
    # read_interim_time = 0  # error: read_interim_time is immutable
    # let_interim_time = 0  # error: let_interim_time is immutable constant
    print("read_interim_time = ", read_interim_time)  # read_interim_time = 0
    print("let_interim_time", let_interim_time)  # unchanged let_interim_time

    var time_list = [let_start_time, let_interim_time]
    ref let_time_list = read_ref(time_list.copy())
    time_list[0] = 0  # This modifies the time_list
    time_list.append(100)  # This modifies time_list
    print("time_list[0] = ", time_list[0])  # time_list[0] = 0
    print("time_list[2] = ", time_list[2])  # time_list[2] = 100

    # let_time_list[0] = 0  # error: let_time_list is immutable constant
    print("let_time_list[0] = ", let_time_list[0])  # unchanged let_start_time

    ref let_end_time = read_ref(time.perf_counter_ns())
    print("interim duration (ns) =", let_time_list[1] - let_time_list[0])
    print("rest duration (ns) = ", let_end_time - let_interim_time)
    print("total duration (ns) = ", let_end_time - let_start_time)
