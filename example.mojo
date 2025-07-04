"""Example of using explicit reference bindings in Mojo.

This example demonstrates how to use `mut_()`, `read_()`, and `var_()`.
"""

from explicit_ref import mut_, read_, var_
from time import *


fn main() raises:
    ref let_start_time = read_(time.perf_counter_ns())

    # ref mut_(start_time = mut_(let_start_time) # error: let_start_time is immutable
    # let_start_time += 1 # error: let_start_time is immutable
    print("let_start_time =", let_start_time)  # unchanged let_start_time

    var meantime = time.perf_counter_ns()
    ref mut_meantime = mut_(meantime)
    ref read_meantime = read_(meantime)
    ref let_meantime = read_(var_(meantime))

    mut_meantime = 0
    # read_(meantime = 0  # error: read_(meantime is an immutable binding
    # let_meantime = 0  # error: let_meantime is a runtime constant
    print("read_meantime = ", read_meantime)  # read_meantime = 0
    print("let_meantime", let_meantime)  # unchanged let_meantime

    var time_list = [let_start_time, let_meantime]
    ref let_time_list = read_(var_(time_list))

    time_list[0] = 0
    time_list.append(100)
    # let_time_list[0] = 0  # error: let_time_list is a runtime constant
    print("time_list[0] = ", time_list[0])  # time_list[0] = 0
    print("time_list[2] = ", time_list[2])  # time_list[2] = 100
    print("let_time_list[0] = ", let_time_list[0])  # unchanged let_time_list

    ref let_end_time = read_(time.perf_counter_ns())
    print("meantime duration (ns) =", let_time_list[1] - let_time_list[0])
    print("remaining duration (ns) = ", let_end_time - let_meantime)
    print("total duration (ns) = ", let_end_time - let_start_time)
