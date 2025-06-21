"""Example of using explicit reference bindings in Mojo.

This example demonstrates how to use `mut()`, `read()`, and `own()`.
"""

from explicit_ref import mut, read, own
from time import *


fn main() raises:
    ref let_start_time = read(time.perf_counter_ns())

    # ref mut_start_time = mut(let_start_time) # error: let_start_time is immutable
    # let_start_time += 1 # error: let_start_time is immutable
    print("let_start_time =", let_start_time)  # unchanged let_start_time

    var interim_time = time.perf_counter_ns()
    ref mut_interim_time = mut(interim_time)
    ref read_interim_time = read(interim_time)
    ref let_interim_time = read(own(interim_time))

    mut_interim_time = 0
    # read_interim_time = 0  # error: read_interim_time is an immutable binding
    # let_interim_time = 0  # error: let_interim_time is a runtime constant
    print("read_interim_time = ", read_interim_time)  # read_interim_time = 0
    print("let_interim_time", let_interim_time)  # unchanged let_interim_time

    var time_list = [let_start_time, let_interim_time]
    ref let_time_list = read(own(time_list))

    time_list[0] = 0
    time_list.append(100)
    # let_time_list[0] = 0  # error: let_time_list is a runtime constant
    print("time_list[0] = ", time_list[0])  # time_list[0] = 0
    print("time_list[2] = ", time_list[2])  # time_list[2] = 100
    print("let_time_list[0] = ", let_time_list[0])  # unchanged let_time_list

    ref let_end_time = read(time.perf_counter_ns())
    print("interim duration (ns) =", let_time_list[1] - let_time_list[0])
    print("remaining duration (ns) = ", let_end_time - let_interim_time)
    print("total duration (ns) = ", let_end_time - let_start_time)
