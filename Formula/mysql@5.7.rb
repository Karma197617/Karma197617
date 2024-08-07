class MysqlAT57 < Formula
  desc "Open source relational database management system"
  homepage "https://dev.mysql.com/doc/refman/5.7/en/"
  url "https://cdn.mysql.com/Downloads/MySQL-5.7/mysql-boost-5.7.42.tar.gz"
  sha256 "7e1a7d45e7ca382eb3a992f63631c380904dd49c89f3382ec950aef01997524f"
  license "GPL-2.0-only"

  livecheck do
    url "https://dev.mysql.com/downloads/mysql/5.7.html?tpl=files&os=src&version=5.7"
    regex(/href=.*?mysql[._-](?:boost[._-])?v?(5\.7(?:\.\d+)*)\.t/i)
  end

  bottle do
    sha256 arm64_ventura:  "05aa7579b79415aa16846741c13225d8188af543c5e3168efc252c9ee685e153"
    sha256 arm64_monterey: "9922a3ebe3231534a5eba0d353e94ffb83261362fdeeac2b405a2b9d08c476e5"
    sha256 arm64_big_sur:  "854462c3816828952cbc26ef03334e88e9b186823c7a84bf5f565cdddd03b053"
    sha256 ventura:        "79e644e4b837659b9f4e04dce261a5964b86c8885ecb84aecbbca4b68db71293"
    sha256 monterey:       "408a1254d1f9e3b344106be544cedd448c7ab57fbfc767c196c6d95756aa604e"
    sha256 big_sur:        "e57da34518ac35421ba103a518d830ff2648dc67a0e9b94255dba18a14478a23"
    sha256 x86_64_linux:   "96d98b89f043528b02f51ffac5446c755a971a529785373e8ca65ecddb68bc3c"
  end

  keg_only :versioned_formula

  # https://www.oracle.com/us/support/library/lifetime-support-technology-069183.pdf
  deprecate! date: "2023-10-01", because: :unsupported

  depends_on "cmake" => :build
  depends_on "libevent"
  depends_on "lz4"
  depends_on "openssl@1.1"
  depends_on "protobuf"

  uses_from_macos "curl"
  uses_from_macos "cyrus-sasl"
  uses_from_macos "libedit"

  on_linux do
    depends_on "pkg-config" => :build
    depends_on "libtirpc"
  end

  def datadir
    var/"mysql"
  end

  # Fixes loading of VERSION file, backported from mysql/mysql-server@51675dd
  patch :DATA

  def install
    if OS.linux?
      # Fix libmysqlgcs.a(gcs_logging.cc.o): relocation R_X86_64_32
      # against `_ZN17Gcs_debug_options12m_debug_noneB5cxx11E' can not be used when making
      # a shared object; recompile with -fPIC
      ENV.append_to_cflags "-fPIC"
    end

    # Fixes loading of VERSION file; used in conjunction with patch
    File.rename "VERSION", "MYSQL_VERSION"

    # -DINSTALL_* are relative to `CMAKE_INSTALL_PREFIX` (`prefix`)
    args = %W[
      -DCOMPILATION_COMMENT=Homebrew
      -DDEFAULT_CHARSET=utf8
      -DDEFAULT_COLLATION=utf8_general_ci
      -DINSTALL_DOCDIR=share/doc/#{name}
      -DINSTALL_INCLUDEDIR=include/mysql
      -DINSTALL_INFODIR=share/info
      -DINSTALL_MANDIR=share/man
      -DINSTALL_MYSQLSHAREDIR=share/mysql
      -DINSTALL_PLUGINDIR=lib/plugin
      -DMYSQL_DATADIR=#{datadir}
      -DSYSCONFDIR=#{etc}
      -DWITH_BOOST=boost
      -DWITH_EDITLINE=system
      -DWITH_SSL=yes
      -DWITH_NUMA=OFF
      -DWITH_UNIT_TESTS=OFF
      -DWITH_EMBEDDED_SERVER=ON
      -DENABLED_LOCAL_INFILE=1
    ]

    args << if OS.mac?
      "-DWITH_INNODB_MEMCACHED=ON" # InnoDB memcached plugin build fails on Linux
    else
      "-DENABLE_DTRACE=0"
    end

    system "cmake", ".", *std_cmake_args, *args
    system "make"
    system "make", "install"

    (prefix/"mysql-test").cd do
      system "./mysql-test-run.pl", "status", "--vardir=#{Dir.mktmpdir}"
    end

    # Remove the tests directory
    rm_rf prefix/"mysql-test"

    # Don't create databases inside of the prefix!
    # See: https://github.com/Homebrew/homebrew/issues/4975
    rm_rf prefix/"data"

    # Fix up the control script and link into bin.
    inreplace "#{prefix}/support-files/mysql.server",
              /^(PATH=".*)(")/,
              "\\1:#{HOMEBREW_PREFIX}/bin\\2"
    bin.install_symlink prefix/"support-files/mysql.server"

    # Install my.cnf that binds to 127.0.0.1 by default
    (buildpath/"my.cnf").write <<~EOS
      # Default Homebrew MySQL server config
      [mysqld]
      # Only allow connections from localhost
      bind-address = 127.0.0.1
    EOS
    etc.install "my.cnf"
  end

  def post_install
    # Make sure the var/mysql directory exists
    (var/"mysql").mkpath

    # Don't initialize database, it clashes when testing other MySQL-like implementations.
    return if ENV["HOMEBREW_GITHUB_ACTIONS"]

    unless (datadir/"mysql/general_log.CSM").exist?
      ENV["TMPDIR"] = nil
      system bin/"mysqld", "--initialize-insecure", "--user=#{ENV["USER"]}",
        "--basedir=#{prefix}", "--datadir=#{datadir}", "--tmpdir=/tmp"
    end
  end

  def caveats
    s = <<~EOS
      We've installed your MySQL database without a root password. To secure it run:
          mysql_secure_installation

      MySQL is configured to only allow connections from localhost by default

      To connect run:
          mysql -uroot
    EOS
    if (my_cnf = ["/etc/my.cnf", "/etc/mysql/my.cnf"].find { |x| File.exist? x })
      s += <<~EOS

        A "#{my_cnf}" from another install may interfere with a Homebrew-built
        server starting up correctly.
      EOS
    end
    s
  end

  service do
    run [opt_bin/"mysqld_safe", "--datadir=#{var}/mysql"]
    keep_alive true
    working_dir var/"mysql"
  end

  test do
    (testpath/"mysql").mkpath
    (testpath/"tmp").mkpath
    system bin/"mysqld", "--no-defaults", "--initialize-insecure", "--user=#{ENV["USER"]}",
      "--basedir=#{prefix}", "--datadir=#{testpath}/mysql", "--tmpdir=#{testpath}/tmp"
    port = free_port
    fork do
      system "#{bin}/mysqld", "--no-defaults", "--user=#{ENV["USER"]}",
        "--datadir=#{testpath}/mysql", "--port=#{port}", "--tmpdir=#{testpath}/tmp"
    end
    sleep 5
    assert_match "information_schema",
      shell_output("#{bin}/mysql --port=#{port} --user=root --password= --execute='show databases;'")
    system "#{bin}/mysqladmin", "--port=#{port}", "--user=root", "--password=", "shutdown"
  end
end

__END__
diff --git a/cmake/mysql_version.cmake b/cmake/mysql_version.cmake
index 43d731e..3031258 100644
--- a/cmake/mysql_version.cmake
+++ b/cmake/mysql_version.cmake
@@ -31,7 +31,7 @@ SET(DOT_FRM_VERSION "6")
 
 # Generate "something" to trigger cmake rerun when VERSION changes
 CONFIGURE_FILE(
-  ${CMAKE_SOURCE_DIR}/VERSION
+  ${CMAKE_SOURCE_DIR}/MYSQL_VERSION
   ${CMAKE_BINARY_DIR}/VERSION.dep
 )
 
@@ -39,7 +39,7 @@ CONFIGURE_FILE(
 
 MACRO(MYSQL_GET_CONFIG_VALUE keyword var)
  IF(NOT ${var})
-   FILE (STRINGS ${CMAKE_SOURCE_DIR}/VERSION str REGEX "^[ ]*${keyword}=")
+   FILE (STRINGS ${CMAKE_SOURCE_DIR}/MYSQL_VERSION str REGEX "^[ ]*${keyword}=")
    IF(str)
      STRING(REPLACE "${keyword}=" "" str ${str})
      STRING(REGEX REPLACE  "[ ].*" ""  str "${str}")

