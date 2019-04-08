class Librpc < Formula
  desc "A general-purpose IPC/RPC library supporting asynchronous notifications, data streaming, exchange of file descriptors and WebSockets endpoint. Loosely based on Apple XPC interface."
  homepage "https://github.com/twoporeguys/librpc"
  url "https://github.com/twoporeguys/librpc/archive/v0.4.1.tar.gz"
  sha256 "adce3d7a1d8c204c106fb8d7debc44af8e0514b9209162c7627dc9fea4221eb3"

  option "with-python@2", "Build with Python2 bindings"
  option "with-python", "Build with Python3 binding"

  depends_on "python@2" => :optional
  depends_on "python" => :optional

  depends_on "cmake"
  depends_on "libsoup"
  depends_on "glib"
  depends_on "yajl"
  depends_on "libusb"
  depends_on "libyaml"

  def install
    mkdir "build" do
      if build.with?("python@2") && build.with?("python")
        odie "For now --with-python@2 and --with-python options are mutually exclusive"
      end

      if build.with? "python@2"
        pyver = Language::Python.major_minor_version "python2"
        system "pip#{pyver}", "install", "-U", "--user", "Cython==0.29.6"
        system "pip#{pyver}", "install", "--user", "enum34"
        system "cmake", "..", "-DBUILD_LIBUSB=ON", "-DPYTHON_VERSION=python#{pyver}", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DENABLE_LIBDISPATCH=ON", "-DBUILD_CPLUSPLUS=OFF"
      end

      if build.with? "python"
        pyver = Language::Python.major_minor_version "python3"
        system "pip#{pyver}", "install", "-U", "--user", "Cython==0.29.6"
        system "cmake", "..", "-DBUILD_LIBUSB=ON", "-DPYTHON_VERSION=python#{pyver}", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DENABLE_LIBDISPATCH=ON", "-DBUILD_CPLUSPLUS=OFF"
      end

      if build.without?("python@2") && build.without?("python")
        system "cmake", "..", "-DBUILD_LIBUSB=ON", "-DBUILD_PYTHON=OFF", "-DCMAKE_INSTALL_PREFIX=#{prefix}", "-DENABLE_LIBDISPATCH=ON", "-DBUILD_CPLUSPLUS=OFF"
      end

      system "make", "install"
    end
  end

  test do
    system "/usr/local/bin/python2.7", "-c", "'import librpc'"
  end
end
