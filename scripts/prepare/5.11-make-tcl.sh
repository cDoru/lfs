#!/bin/bash
set -e
echo "Building tcl.."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 42 MB"

# 5.11.Tcl package contains the Tool Command Language
tar -xf tcl-core*-src.tar.gz -C /tmp/ \
  && mv /tmp/tcl* /tmp/tcl-core \
  && pushd /tmp/tcl-core \
  && cd unix \
  && ./configure --prefix=/tools \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then TZ=UTC make test; fi \
  && make install \
  && chmod -v u+w /tools/lib/libtcl8.6.so \
  && make install-private-headers \
  && ln -sv tclsh8.6 /tools/bin/tclsh \
  && popd \
  && rm -rf /tmp/tcl-core
