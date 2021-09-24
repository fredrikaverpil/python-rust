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

# Install Rust
curl https://sh.rustup.rs -sSf | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    "${PYBIN}/pip" install --upgrade pip
    "${PYBIN}/pip" install -r /io/requirements.txt
    "${PYBIN}/pip" wheel /io --no-deps -w /io/wheelhouse/
done

# Bundle external shared libraries into the wheels
for whl in /io/wheelhouse/*.whl; do
    repair_wheel "$whl"
done

# Store in dist folder
mkdir -p /io/dist/
for whl in /io/wheelhouse/*.whl; do
    if [[ "$whl" == *"manylinux"* ]]; then
        cp "$whl" /io/dist/
    fi
done
