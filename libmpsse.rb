# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libmpsse < Formula
  desc "Library for interface with SPI/I2C via FTDI's FT-2232 family"
  homepage "https://code.google.com/p/libmpsse/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/libmpsse/libmpsse-1.3.tar.gz"
  version "1.3"
  sha256 "08f2a0025074720d40e29430089b1ab78d764756cc5d2bcb3148d98131b4074b"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "swig"
  depends_on "python" => :recommended

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-ftdi/raw/master/Makefile.in.patch'
    sha256 'de1b312373f003d019ee2ba64800a08bf3a217b1b3b2479582f8ff1aca6a3b33'
  end

  patch :p0 do
    url 'https://raw.githubusercontent.com/zegervdv/homebrew-ftdi/master/mpsse.c.patch'
    sha256 '54a9dafe1b8fbd5010843dde1ce9d99183ba7673daeb4803c847de3097d0e846'
  end

  patch :p0 do
    url 'https://raw.githubusercontent.com/zegervdv/homebrew-ftdi/master/mpsse.h.patch'
    sha256 'd38458dcf9aeced05c6153cef3843c0829190dff57410507fb312947622229bf'
  end

  patch :p0 do
    url 'https://raw.githubusercontent.com/zegervdv/homebrew-ftdi/master/support.c.patch'
    sha256 '3aea7d0e3c35048ab36d35ab25c7939b350a365bc806040e35b61eebaf0e7f13'
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    cd 'src' do
      pydev = `python-config --includes`.match /-I([^ ]*)/
      pyflags = `python-config --ldflags`
      ENV.prepend_create_path "PYDEV", pydev[1]
      ENV.prepend_create_path "PYLIB", lib/"python2.7/site-packages"
      ENV.prepend_create_path "LDFLAGS", pyflags
      system "./configure", "--disable-debug",
                            "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{prefix}"
      # system "cmake", ".", *std_cmake_args
      mkdir_p prefix/lib
      mkdir_p prefix/include
      system "make"
      system "make install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libmpsse`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
