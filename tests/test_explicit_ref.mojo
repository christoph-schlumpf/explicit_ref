from explicit_ref import mut_, read_, var_
from testing import assert_equal


def test_mut():
    """Test `mut` reference binding."""
    var a = [1, 2, 3]
    ref mut_a = mut_(a)

    assert_equal(mut_a[0], a[0])

    mut_a[0] = 10

    assert_equal(mut_a[0], 10)
    assert_equal(a[0], 10)

    a[0] = 20
    assert_equal(mut_a[0], 20)

    a.append(30)
    assert_equal(mut_a[3], 30)


def test_read():
    """Test `read` reference binding."""
    var a = [1, 2, 3]
    ref read_a = read_(a)

    assert_equal(read_a[0], a[0])

    # read_a[0] = 10  # error: read_a is immutable

    a[0] = 20
    assert_equal(read_a[0], 20)


def test_let():
    """Test `let` reference binding."""
    var a = [1, 2, 3]
    ref let_a = read_(var_(a))

    assert_equal(let_a[0], a[0])

    # let_a[0] = 10  # error: let_a is a runtime constant

    a[0] = 20
    assert_equal(let_a[0], 1)

    a.append(30)
    assert_equal(len(let_a), 3)
