class Pocsuite3 < Formula
  include Language::Python::Virtualenv

  desc "Open-sourced remote vulnerability testing framework"
  homepage "https://pocsuite.org/"
  url "https://files.pythonhosted.org/packages/98/9c/ea5c93f0cff8ffbe776ae138569219c2f0c7e43d94c002fe21e607d186e6/pocsuite3-2.0.4.tar.gz"
  sha256 "57dd1e565595bd705667a4e0df72e288321640f938e1fefcc83b02a70dda099d"
  license "GPL-2.0-only"
  head "https://github.com/knownsec/pocsuite3.git", branch: "master"

  bottle do
    sha256 cellar: :any,                 arm64_ventura:  "4d3ae40d4ec45caf09d74d1aaef1667911bb91a142914fd57e3b9d0a88ee1155"
    sha256 cellar: :any,                 arm64_monterey: "acd61884c3d228a78bf4af25d01cac011378c75557a9c9fb2d647714b4576cc7"
    sha256 cellar: :any,                 arm64_big_sur:  "55c1010d18ccb49535ce06a4f05e1a980adc5ca70aba066c38ebf400c43fa89e"
    sha256 cellar: :any,                 ventura:        "71db28b65fef2a7ff8b8ab02e377052e8144cb2ecc576347f5282d3ec89600b3"
    sha256 cellar: :any,                 monterey:       "f3cf115708033ba62801c87faf9b1772ce602eaa0ab7a43dab5b1b64ad72bd06"
    sha256 cellar: :any,                 big_sur:        "9e24e155f2026edda0f0413d10cde8e88ebf27b33e414d0d9de91cf02b30cf49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0cce290d9e6f892492a837c735dfd4a4d1b9526e75741f20d8ead75cca8cc41e"
  end

  depends_on "rust" => :build # for cryptography
  depends_on "python@3.11"
  depends_on "pyyaml"
  depends_on "six"

  uses_from_macos "libffi"
  uses_from_macos "libxml2"
  uses_from_macos "libxslt"

  on_linux do
    depends_on "pkg-config" => :build
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69/certifi-2022.12.7.tar.gz"
    sha256 "35824b4c3a97115964b408844d64aa14db1cc518f6562e8d7261699d1350a9e3"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2b/a8/050ab4f0c3d4c1b8aaa805f70e26e84d0e27004907c5b8ecc1d31815f92a/cffi-1.15.1.tar.gz"
    sha256 "d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/41/32/cdc91dcf83849c7385bf8e2a5693d87376536ed000807fa07f5eab33430d/chardet-5.1.0.tar.gz"
    sha256 "0d62712b956bc154f85fb0a266e2a3c5913c2967e00348701b32411d6def31e5"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/ff/d7/8d757f8bd45be079d76309248845a04f09619a7b17d6dfc8c9ff6433cac2/charset-normalizer-3.1.0.tar.gz"
    sha256 "34e0a2f9c370eb95597aae63bf85eb5e96826d81e3dcf88b8886012906f509b5"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4/colorama-0.4.6.tar.gz"
    sha256 "08695f5cb7ed6e0531a20572697297273c47b8cae5a63ffc6d6ed5c201be6e44"
  end

  resource "colorlog" do
    url "https://files.pythonhosted.org/packages/78/6b/4e5481ddcdb9c255b2715f54c863629f1543e97bc8c309d1c5c131ad14f2/colorlog-6.7.0.tar.gz"
    sha256 "bd94bd21c1e13fac7bd3153f4bc3a7dc0eb0974b8bc2fdf1a989e474f6e582e5"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/f7/80/04cc7637238b78f8e7354900817135c5a23cf66dfb3f3a216c6d630d6833/cryptography-40.0.2.tar.gz"
    sha256 "c33c0d32b8594fa647d2e01dbccc303478e16fdd7cf98652d5b3ed11aa5e5c99"
  end

  resource "dacite" do
    url "https://files.pythonhosted.org/packages/6f/6d/f7ee0f5410665cdfbd56d0caf5da9217410348e5a0c11d3e6cfe1c1ddd7a/dacite-1.8.0.tar.gz"
    sha256 "6257a5e505b61a8cafee7ef3ad08cf32ee9b885718f42395d017e0a9b4c6af65"
  end

  resource "faker" do
    url "https://files.pythonhosted.org/packages/22/cd/72893a69f7382a0d8459d6aaa643c8c1da1a47e19beb8f467edbf2929229/Faker-18.6.0.tar.gz"
    sha256 "ac903ba8cb5adbce2cdd15e5536118d484bbe01126f3c774dd9f6df77b61232d"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/8b/e1/43beb3d38dba6cb420cefa297822eac205a277ab43e5ba5d5c46faf96438/idna-3.4.tar.gz"
    sha256 "814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4"
  end

  resource "jq" do
    url "https://files.pythonhosted.org/packages/6e/b1/44632550d22e1a151273ad0555c8149656c6fd019f5fad0b9cd789059a2b/jq-1.4.1.tar.gz"
    sha256 "52284ee3cb51670e6f537b0ec813654c064c1c0705bd910097ea0fe17313516d"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/06/5a/e11cad7b79f2cf3dd2ff8f81fa8ca667e7591d3d8451768589996b65dec1/lxml-4.9.2.tar.gz"
    sha256 "2455cfaeb7ac70338b3257f41e21f0724f4b5b0c0e7702da67ee6c3640835b67"
  end

  resource "mmh3" do
    url "https://files.pythonhosted.org/packages/73/65/33dce4b13a77ed6aeb1f41994240cc4d3c49fb79b3acdac9a502ae6e254d/mmh3-3.1.0.tar.gz"
    sha256 "9b0f2b2ab4a915333c9d1089572e290a021ebb5b900bb7f7114dccc03995d732"
  end

  resource "prettytable" do
    url "https://files.pythonhosted.org/packages/95/8d/f6b4448e386eb1382a99cbceabe3899f3aa431992582cc90496843548303/prettytable-3.7.0.tar.gz"
    sha256 "ef8334ee40b7ec721651fc4d37ecc7bb2ef55fde5098d994438f0dfdaa385c0c"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end

  resource "pycryptodomex" do
    url "https://files.pythonhosted.org/packages/3d/07/cfd8f52b9068877801317d26dc7225e19421bc659e1395d2cd6933b1a351/pycryptodomex-3.17.tar.gz"
    sha256 "0af93aad8d62e810247beedef0261c148790c52f3cd33643791cc6396dd217c1"
  end

  resource "pyopenssl" do
    url "https://files.pythonhosted.org/packages/8f/72/f1d9e92f5d3a58aba3b71ad512de19eb9f82e7b98795662bf7b796be71e5/pyOpenSSL-23.1.1.tar.gz"
    sha256 "841498b9bec61623b1b6c47ebbc02367c07d60e0e195f19790817f10cc8db0b7"
  end

  resource "pysocks" do
    url "https://files.pythonhosted.org/packages/bd/11/293dd436aea955d45fc4e8a35b6ae7270f5b8e00b53cf6c024c83b657a11/PySocks-1.7.1.tar.gz"
    sha256 "3f8804571ebe159c380ac6de37643bb4685970655d3bba243530d6558b799aa0"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/4c/d2/70fc708727b62d55bc24e43cc85f073039023212d482553d853c44e57bdb/requests-2.29.0.tar.gz"
    sha256 "f2e34a75f4749019bb0e3effb66683630e4ffeaf75819fb51bebef1bf5aef059"
  end

  resource "requests-toolbelt" do
    url "https://files.pythonhosted.org/packages/0c/4c/07f01c6ac44f7784fa399137fbc8d0cdc1b5d35304e8c0f278ad82105b58/requests-toolbelt-0.10.1.tar.gz"
    sha256 "62e09f7ff5ccbda92772a29f394a49c3ad6cb181d568b1337626b2abb628a63d"
  end

  resource "scapy" do
    url "https://files.pythonhosted.org/packages/67/a1/2a60d5b6f0fed297dd0c0311c887d5e8a30ba1250506585b897e5a662f4c/scapy-2.5.0.tar.gz"
    sha256 "5b260c2b754fd8d409ba83ee7aee294ecdbb2c235f9f78fe90bc11cb6e5debc2"
  end

  resource "termcolor" do
    url "https://files.pythonhosted.org/packages/b8/85/147a0529b4e80b6b9d021ca8db3a820fcac53ec7374b87073d004aaf444c/termcolor-2.3.0.tar.gz"
    sha256 "b5b08f68937f138fe92f6c089b99f1e2da0ae56c52b78bf7075fd95420fd9a5a"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/21/79/6372d8c0d0641b4072889f3ff84f279b738cd8595b64c8e0496d4e848122/urllib3-1.26.15.tar.gz"
    sha256 "8a388717b9476f934a21484e8c8e61875ab60644d29b9b39e11e4b9dc1c6b305"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/5e/5f/1e4bd82a9cc1f17b2c2361a2d876d4c38973a997003ba5eb400e8a932b6c/wcwidth-0.2.6.tar.gz"
    sha256 "a5220780a404dbe3353789870978e472cfe477761f06ee55077256e509b156d0"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Module (pocs_ecshop_rce) options:", shell_output("#{bin}/pocsuite -k ecshop --options")
  end
end
