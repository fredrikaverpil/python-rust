#!/bin/bash
set -e -u -x

function repair_wheel {
    wheel="$1"
    if ! auditwheel show "$wheel"; then
        echo "Skipping non-platform wheel $wheel"
    else
        auditwheel repair "$wheel" --plat "$PLAT" -w /io/wheelhouse/
    fi
}

# Install a system package required by our library
# yum install -y atlas-devel

# Install Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" install --upgrade pip
    "${PYBIN}/pip" install -r /io/requirements.txt
    "${PYBIN}/pip" wheel /io/package --no-deps -w /io/wheelhouse/
done

# Bundle external shared libraries into the wheels
for whl in /io/wheelhouse/*.whl; do
    repair_wheel "$whl"
done

# Store in dist folder
mkdir -p /io/package/dist/
for whl in /io/wheelhouse/*.whl; do
    cp "$whl" /io/package/dist/
done

# # Install packages and test
# for PYBIN in /opt/python/*/bin/; do
#     "${PYBIN}/pip" install python-manylinux-demo --no-index -f /io/wheelhouse
#     (cd "$HOME"; "${PYBIN}/nosetests" pymanylinuxdemo)
# done