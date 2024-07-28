class Tiff2png < Formula
  desc "TIFF to PNG converter"
  homepage "http://www.libpng.org/pub/png/apps/tiff2png.html"
  url "https://github.com/rillian/tiff2png/archive/v0.92.tar.gz"
  sha256 "64e746560b775c3bd90f53f1b9e482f793d80ea6e7f5d90ce92645fd1cd27e4a"
  license "ISC"
  revision 3

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "cb4f278f194339e85a3e75b701c29e471b718760ad14bb10580bb546a3314e89"
    sha256 cellar: :any,                 arm64_monterey: "0ae6b6e42ee87ba89102282f21f1b7e4bbe98ded275f363a91e47ec9f0ec3cb2"
    sha256 cellar: :any,                 arm64_big_sur:  "3df140d14c8a0c8247e1157ddb05ff9e5249b7115e26871c0eb498b43eccc180"
    sha256 cellar: :any,                 ventura:        "77ab7ae23d1ee2add50645d344474f641c21abd8da1df66eb84b0e312a41cca6"
    sha256 cellar: :any,                 monterey:       "80039b863040ebc5f7868d5331c358ee3ef0f210520eeb45a11cb746a406ebd0"
    sha256 cellar: :any,                 big_sur:        "bd5b088f08568c294627c010ca998e811a6ff11251299fec4df84caa35db8c74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a3c16e66fef90676d5b183e53657435b8f97e2f80832391edddae38ee523c02a"
  end

  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"

  def install
    bin.mkpath
    system "make", "INSTALL=#{prefix}", "CC=#{ENV.cc}", "install"
  end

  test do
    system "#{bin}/tiff2png", test_fixtures("test.tiff")
  end
end
