class Librpc < Formula
  desc "A general-purpose IPC/RPC library supporting asynchronous notifications, data streaming, exchange of file descriptors and WebSockets endpoint. Loosely based on Apple XPC interface."
  homepage "https://github.com/twoporeguys/librpc"
  url "https://github.com/twoporeguys/librpc/archive/master.tar.gz"
  version "1.0"

  option "with-python", "Build with python2 bindings"
  option "with-python3", "Build with python3 binding"

  depends_on :python => :optional
  depends_on :python3 => :optional

  depends_on "cmake"
  depends_on "libsoup"
  depends_on "glib"
  depends_on "yajl"
  depends_on "libusb"
  depends_on "libyaml"

  def install
    if build.with? "python"
        pyver = Language::Python.major_minor_version "python2"
        system "#{pyver}", "-m", "pip", "install", "--user", "Cython"
	system "#{pyver}", "-m", "pip", "install", "--user", "enum34"
	system "make", "PYTHON_VERSION=#{pyver}", "INSTALL_PREFIX=#{prefix}"
	system "make", "install"
    end

    if build.with? "python3"
        pyver = Language::Python.major_minor_version "python3"
        system "#{pyver}", "-m", "pip", "install", "--user", "Cython"
	system "make", "PYTHON_VERSION=#{pyver}", "INSTALL_PREFIX=#{prefix}"
	system "make", "install"
    end

    if build.without?("python") && build.without?("python3")
	system "make", "BUILD_PYTHON=OFF", "INSTALL_PREFIX=#{prefix}"
	system "make", "install"
    end
  end

  test do
	  system "/usr/local/bin/python2.7", "-c", "'import librpc'"
  end
end
