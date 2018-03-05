class Libadcusb < Formula
  desc "ADC data transfer library"
  homepage "https://github.com/twoporeguys/libadcusb"
  url "https://github.com/twoporeguys/libadcusb/archive/v0.1.6.tar.gz"
  sha256 "4046208626a1ed63d6d7f7315d463f9a5c9d7ce99533ab10bb80bfb523543c2c"

  option "with-python", "Build with Python2 bindings"
  option "with-python3", "Build with Python3 binding"
 
  depends_on "python@2" => :optional
  depends_on "python" => :optional

  depends_on "cmake"
  depends_on "glib"
  depends_on "libusb"
  depends_on "numpy"

  def install
    if build.with?("python") && build.with?("python3")
      odie "For now --with-python and --with-python3 options are mutually exclusive"
    end 

    if build.with? "python"
      pyver = Language::Python.major_minor_version "python2"
    end

    if build.with? "python3"
      pyver = Language::Python.major_minor_version "python3"
    end

    if build.with?("python") || build.with?("python3")
      system "pip#{pyver}", "install", "--user", "Cython==0.26.1"
      system "make", "PYTHON_VERSION=python#{pyver}", "INSTALL_PREFIX=#{prefix}"
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
