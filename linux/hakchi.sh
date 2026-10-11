#!/bin/sh
# Launches Hakchi2 CE under Mono on Linux.
here="$(cd "$(dirname "$0")" && pwd)"

if ! command -v mono >/dev/null 2>&1; then
  echo "hakchi: 'mono' was not found. Install Mono and libgdiplus first (see README-linux.md)." >&2
  exit 1
fi

# Mono looks for libusb as "libusb-1.0.so", which most distros only ship in their -dev package.
# If only the runtime library (libusb-1.0.so.0) is installed, point Mono at it through a private symlink.
ldconfig_p() { PATH="$PATH:/sbin:/usr/sbin" ldconfig -p 2>/dev/null; }
if ! ldconfig_p | grep -q 'libusb-1\.0\.so '; then
  case "$(uname -m)" in
    x86_64) arch="x86-64" ;;
    aarch64) arch="AArch64" ;;
    *) arch="" ;;
  esac
  lib="$(ldconfig_p | grep 'libusb-1\.0\.so\.0 ' | grep -F "$arch" | sed 's/.*=> //' | head -n 1)"
  if [ -n "$lib" ]; then
    shim="${XDG_CACHE_HOME:-$HOME/.cache}/hakchi2-ce/lib"
    mkdir -p "$shim" && ln -sf "$lib" "$shim/libusb-1.0.so"
    export LD_LIBRARY_PATH="$shim${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
  else
    echo "hakchi: libusb-1.0 not found; USB (FEL/clovershell) connections will not work." >&2
  fi
fi

cd "$here" || exit 1
exec mono hakchi.exe "$@"
