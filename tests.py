import mylib

def test_mylib():
    data = "Hello world"
    assert mylib.get_result(data) == f"Rust says: {data}"