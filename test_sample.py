# test_sample.py

import pytest
from sample import add

@pytest.mark.parametrize("a, b, expected", [
    (1, 2, 3),
    (10, 20, 30),
    (-1, -1, -2),
    (0, 0, 0)
])
def test_add(a, b, expected):
    assert add(a, b) == expected
