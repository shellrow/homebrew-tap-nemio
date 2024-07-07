class Nemio < Formula
  desc "Simple and Fast Network Mapper"
  homepage "https://github.com/shellrow/nemio"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shellrow/nemio/releases/download/v0.2.0/nemio-aarch64-apple-darwin.tar.xz"
      sha256 "d6900c0f1a715a9654af8a27ba2674ec1cf82e30d91a2bb3d0b6beb84ec55efa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nemio/releases/download/v0.2.0/nemio-x86_64-apple-darwin.tar.xz"
      sha256 "273e93ed6a81e050408d4d4f50f8f7a467fc7de2eed5a138615d18a1d243feb7"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nemio/releases/download/v0.2.0/nemio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb9f660ccc2332b8efd22ad4eb07ec2c2d233b17c7a2f53eb73a98e78420a2ab"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "nemio"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nemio"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nemio"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
