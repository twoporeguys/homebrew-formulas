class Librpc < Formula
  desc "A general-purpose IPC/RPC library supporting asynchronous notifications, data streaming, exchange of file descriptors and WebSockets endpoint. Loosely based on Apple XPC interface."
  homepage "https://github.com/twoporeguys/librpc"
  url "https://github.com/twoporeguys/librpc/archive/master.tar.gz"
  version "1.0"

  depends_on "cmake"
  depends_on "libsoup"
  depends_on "glib"
  depends_on "yajl"
  depends_on "libusb"
  depends_on "libyaml"
  depends_on "python"
  depends_on "cython"

  def install
    system "cmake", "-DBUILD_LIBUSB=ON", "-DPYTHON_VERSION=/usr/local/bin/python2"
    system "make"
    system "make", "install"
  end

  test do
    system "python3", "-c", "'import librpc'"
  end
end
