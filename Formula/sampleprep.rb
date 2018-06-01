class Sampleprep < Formula
  desc "All things needed for TPG sampleprep"
  # The next URL can point to any gz file. 
  # It's not possible to do this without gz files... yet.
  # Unless https://github.com/Homebrew/brew/issues/2300 is resolved
  url "https://github.com/twoporeguys/librpc/archive/v0.3.2.tar.gz"
  sha256 "9fdc9c8ce68351b32881c7c9491223ec7b1285eca1f7417ea739d3e916eb4e26"

  depends_on "librpc"     => ["with-python"]
  depends_on "libadcusb"  => ["with-python"]
  depends_on "gtk+3"      => ["with-python"]
  depends_on "pygobject3" => ["with-python"]

 def install
   pyver = Language::Python.major_minor_version "python3"
   system "pip#{pyver}", "install", "--user", "cairocffi"
   system "pip#{pyver}", "install", "--user", "matplotlib"
 end

  test do
    system "/usr/local/bin/python3", "-c", "'import gi'"
  end

end
