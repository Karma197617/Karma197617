class Cadence < Formula
  desc "Resource-oriented smart contract programming language"
  homepage "https://github.com/onflow/cadence"
  url "https://github.com/onflow/cadence/archive/v0.39.0.tar.gz"
  sha256 "4bac87a6bc9118068f92a91b11ab4dbb32fdf7c6f46e2559d1f5b9019267f4d4"
  license "Apache-2.0"
  head "https://github.com/onflow/cadence.git", branch: "master"

  # Upstream uses GitHub releases to indicate that a version is released
  # (there's also sometimes a notable gap between when a version is tagged and
  # and the release is created), so the `GithubLatest` strategy is necessary.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e0e83d1c534b4fe5c555d83283ff5c6269adf49c61ee95ee0742d60825b0a103"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e0e83d1c534b4fe5c555d83283ff5c6269adf49c61ee95ee0742d60825b0a103"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e0e83d1c534b4fe5c555d83283ff5c6269adf49c61ee95ee0742d60825b0a103"
    sha256 cellar: :any_skip_relocation, ventura:        "bd8723cf6ffeacada0aab56ecebe3fd4a3504937c183df8b57f102e06d01933f"
    sha256 cellar: :any_skip_relocation, monterey:       "bd8723cf6ffeacada0aab56ecebe3fd4a3504937c183df8b57f102e06d01933f"
    sha256 cellar: :any_skip_relocation, big_sur:        "bd8723cf6ffeacada0aab56ecebe3fd4a3504937c183df8b57f102e06d01933f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0b7a554284b25c80f3644a225ea1b111427c92a7b664c7aa495561b76fbf9a35"
  end

  depends_on "go" => :build

  conflicts_with "cadence-workflow", because: "both install a `cadence` executable"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./runtime/cmd/main"
  end

  test do
    (testpath/"hello.cdc").write <<~EOS
      pub fun main(): Int {
        return 0
      }
    EOS
    system "#{bin}/cadence", "hello.cdc"
  end
end
