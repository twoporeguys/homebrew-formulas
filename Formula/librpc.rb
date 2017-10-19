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

  def install
    system "/usr/local/bin/pip2.7", "install", "Cython"	    
    system "make", "PYTHON_VERSION=python2.7"
    system "make", "install"
  end

  test do
	  system "/usr/local/bin/python2.7", "-c", "'import librpc'"
  end
end
