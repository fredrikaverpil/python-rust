import mylib

def test_mylib():
    data = "Hello world"
    assert mylib.get_results(data) == f"Rust says: {data}"