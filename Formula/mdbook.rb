class Mdbook < Formula
  desc "Create modern online books from Markdown files"
  homepage "https://rust-lang.github.io/mdBook/"
  url "https://github.com/rust-lang/mdBook/archive/v0.4.24.tar.gz"
  sha256 "fe291fb8eea8afece79d83c465f4e9ae2f0094aca0fb11ab2eb34601b436895f"
  license "MPL-2.0"
  head "https://github.com/rust-lang/mdBook.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2de84e4e3ee16a1b972cc2d097b19fb5a656dff3278cd48a847f592aed4c952b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "078dcac90dceb65af12007d43c6757605135078dfcf1a53cf95c6e3caf0000b4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "32ee29f893d944e24932ad3083ca093314c26e8ab6baa6470d65a9c9535e2a96"
    sha256 cellar: :any_skip_relocation, ventura:        "5ccd14ab6b3d149ea3418fee8221c5539c7493f5e6efeb53573308b8f96872b6"
    sha256 cellar: :any_skip_relocation, monterey:       "90c2488fc75996a99fed43ce0d0de0fd6c2f54510fff2da8a2e1a612cb06a8f4"
    sha256 cellar: :any_skip_relocation, big_sur:        "87be6b8f05c49334fbb52019351539e4c6f0ef6dacc5e20f21dd8d6a9dea78ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "00f61b4798f0f32aa634f61a088a56267472df33da670118c7f0d384c4e065fd"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # simulate user input to mdbook init
    system "sh", "-c", "printf \\n\\n | #{bin}/mdbook init"
    system bin/"mdbook", "build"
  end
end
