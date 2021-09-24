import sys

from setuptools import setup
from setuptools import find_packages
from setuptools_rust import Binding, RustExtension

setup(
    name="mylib",
    setup_requires=["setuptools", "wheel", "setuptools-rust"],
    version="0.0.1",
    rust_extensions=[RustExtension(target="mylib.mylib", binding=Binding.RustCPython)],
    package_dir={"": "src/python"},
    packages=find_packages(
        where='src/python',
        include=['mylib*'],
        # exclude=['additional'],
    ),
    include_package_data=True,
    # Rust extensions are not zip safe
    zip_safe=False
)