require "formula"

class AflFuzz < Formula
  homepage "http://lcamtuf.coredump.cx/afl/"
  url "http://lcamtuf.coredump.cx/afl/releases/afl-1.61b.tgz"
  sha256 "dfab81c17698c251887129b67d5eef3d50ab7103f222d554d8f0dde5b9ae6f6f"

  head "http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz"

  bottle do
    sha1 "7ac67d41c4c6943e9fad65ac6556454fc01326a0" => :yosemite
    sha1 "0fca06e7c6c9e2bda8274407eff2032b57c4f909" => :mavericks
    sha1 "8ad499d0b9276c37795e0ac460c1a9b17d1b9376" => :mountain_lion
  end

  def install
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    cpp_file = testpath/"main.cpp"
    exe_file = testpath/"test"

    cpp_file.write <<-EOS.undent
      #include <iostream>

      int main() {
        std::cout << "Hello, world!";
      }
    EOS

    system "#{bin}/afl-clang++", "-g", cpp_file, "-o", exe_file
    output = `#{exe_file}`
    assert_equal 0, $?.exitstatus
    assert_equal output, "Hello, world!"
  end
end
