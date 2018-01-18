class Librpc < Formula
  desc "A general-purpose IPC/RPC library supporting asynchronous notifications, data streaming, exchange of file descriptors and WebSockets endpoint. Loosely based on Apple XPC interface."
  homepage "https://github.com/twoporeguys/librpc"
  url "https://github.com/twoporeguys/librpc/archive/v0.3.2.tar.gz"
  sha256 "9fdc9c8ce68351b32881c7c9491223ec7b1285eca1f7417ea739d3e916eb4e26"

  option "with-python", "Build with Python2 bindings"
  option "with-python3", "Build with Python3 binding"
  option "with-dbgsym", "Build with debug symbols"

  depends_on :python => :optional
  depends_on :python3 => :optional

  depends_on "cmake"
  depends_on "libsoup"
  depends_on "glib"
  depends_on "yajl"
  depends_on "libusb"
  depends_on "libyaml"

  def install
    if build.with?("python") && build.with?("python3")
      odie "For now --with-python and --with-python3 options are mutually exclusive"
    end 

    system "mkdir", "-p", "build"
    build_type = build.with?("dbgsym") ? "Debug" : "Release"
    
    if build.with? "python"
      pyver = Language::Python.major_minor_version "python2"
      system "pip#{pyver}", "install", "--user", "Cython==0.26.1"
      system "pip#{pyver}", "install", "--user", "enum34"
      system "cd", "build", "&&", "cmake", "..", "-DBUILD_LIBUSB=ON", "-DPYTHON_VERSION=python#{pyver}", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DENABLE_LIBDISPATCH=ON", "-DCMAKE_BUILD_TYPE=#{build_type}"
    end

    if build.with? "python3"
      pyver = Language::Python.major_minor_version "python3"
      system "pip#{pyver}", "install", "--user", "Cython==0.26.1"
      system "cd", "build", "&&", "cmake", "..", "-DBUILD_LIBUSB=ON", "-DPYTHON_VERSION=python#{pyver}", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DENABLE_LIBDISPATCH=ON", "-DCMAKE_BUILD_TYPE=#{build_type}"
    end
    
    if build.without?("python") && build.without?("python3")
      system "cd", "build", "&&", "cmake", "..", "-DBUILD_LIBUSB=ON", "-DBUILD_PYTHON=OFF", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DENABLE_LIBDISPATCH=ON", "-DCMAKE_BUILD_TYPE=#{build_type}"
    end

    system "make", "-C", "build", "install"
  end

  test do
    system "/usr/local/bin/python2.7", "-c", "'import librpc'"
  end
end
