class Libadcusb < Formula
  desc "ADC data transfer library"
  homepage "https://github.com/twoporeguys/libadcusb"
  url "https://github.com/twoporeguys/libadcusb/archive/v0.1.7.tar.gz"
  sha256 "29a17566396e08c56687b5b890b52de65eb8b5cea629c144a0634a7b8c5a553e"

  option "with-python@2", "Build with Python2 bindings"
  option "with-python", "Build with Python3 binding"

  depends_on "python@2" => :optional
  depends_on "python" => :optional

  depends_on "cmake"
  depends_on "glib"
  depends_on "libusb"
  depends_on "numpy"

  def install
    if build.with?("python@2") && build.with?("python")
      odie "For now --with-python@2 and --with-python options are mutually exclusive"
    end

    if build.with? "python@2"
      pyver = Language::Python.major_minor_version "python2"
      system "pip#{pyver}", "install", "-U", "--user", "Cython==0.29.6"
      system "make", "PYTHON_VERSION=python#{pyver}", "INSTALL_PREFIX=#{prefix}"
      system "make", "install"
    end

    if build.with? "python"
      pyver = Language::Python.major_minor_version "python3"
      system "pip#{pyver}", "install", "-U", "--user", "Cython==0.29.6"
      system "make", "PYTHON_VERSION=python#{pyver}", "INSTALL_PREFIX=#{prefix}"
      system "make", "install"
    end

    if build.without?("python@2") && build.without?("python")
      system "make", "BUILD_PYTHON=OFF", "INSTALL_PREFIX=#{prefix}"
      system "make", "install"
    end
  end

  test do
    system "/usr/local/bin/python2.7", "-c", "'import adcusb'"
  end
end
