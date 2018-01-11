class Sampleprep < Formula
  desc "All things needed for TPG sampleprep"

  depends_on "librpc" => :python3
  depends_on "libadcusb" => :python3
  depends_on "pygobject3" => ["with-python3", "gtk+3"]
 

  def install
    pyver = Language::Python.major_minor_version "python3"
    system "pip#{pyver}", "install", "--user", "cairocffi"
    system "pip#{pyver}", "install", "--user", "matplotlib"
  end

  test do
    system "/usr/local/bin/python3", "-c", "'import gi'"
  end
end
