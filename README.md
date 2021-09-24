# python-rust

Extend Python with fast Rust code.

Uses:

* https://github.com/PyO3/setuptools-rust
* https://github.com/dgrunwald/rust-cpython
* https://github.com/pypa/manylinux
* inspiration from:
  * https://github.com/PyO3/setuptools-rust/tree/main/examples/html-py-ever
  * https://developers.redhat.com/blog/2017/11/16/speed-python-using-rust

Rust is fast:

```bash
$ pytest tests.py

--------------------------------------------------------------------------------- benchmark: 3 tests ---------------------------------------------------------------------------------
Name (time in ms)         Min                Max               Mean            StdDev             Median               IQR            Outliers       OPS            Rounds  Iterations
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
test_rust              1.2336 (1.0)       3.9006 (1.0)       1.3705 (1.0)      0.1779 (1.0)       1.3303 (1.0)      0.1087 (1.0)         46;46  729.6363 (1.0)         529           1
test_regex            19.6905 (15.96)    26.9676 (6.91)     20.9434 (15.28)    1.5184 (8.54)     20.2578 (15.23)    0.8381 (7.71)          8;8   47.7476 (0.07)         45           1
test_pure_python      35.7481 (28.98)    46.7546 (11.99)    39.1124 (28.54)    2.3020 (12.94)    38.1887 (28.71)    2.1153 (19.46)         5;2   25.5673 (0.04)         27           1
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
```