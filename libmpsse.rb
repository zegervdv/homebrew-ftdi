# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libmpsse < Formula
  desc "Library for interface with SPI/I2C via FTDI's FT-2232 family"
  homepage "https://code.google.com/p/libmpsse/"
  url "https://libmpsse.googlecode.com/files/libmpsse-1.3.tar.gz"
  version "1.3"
  sha256 "08f2a0025074720d40e29430089b1ab78d764756cc5d2bcb3148d98131b4074b"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "swig"
  depends_on :python => :recommended

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-ftdi/raw/master/Makefile.in.patch'
    sha1 '139f6399b680ecb565c9ccdd5199a76d972d069e'
  end

  patch :p0 do
    url 'https://github.com/zegervdv/homebrew-ftdi/raw/master/configure.patch'
    sha1 '5ffbc69853f1f24fa4a6cd4452030cc515ad1eb5'
  end


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    cd 'src' do
      pydev = `python-config --includes`.match /-I([^ ]*)/
      pyflags = `python-config --ldflags`
      ENV.prepend_create_path "PYDEV", pydev[1]
      ENV.prepend_create_path "PYLIB", lib/"lib/python2.7/site-packages"
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
