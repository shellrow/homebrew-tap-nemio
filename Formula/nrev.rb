class Nrev < Formula
  desc "Simple and Fast Network Revealer/Mapper."
  homepage "https://github.com/shellrow/nrev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shellrow/nrev/releases/download/v0.1.0/nrev-aarch64-apple-darwin.tar.xz"
      sha256 "173fe3c4ffc1906f94572e4cd6b0b32e26992fcbd35a09b4e5cc60bca35a911a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nrev/releases/download/v0.1.0/nrev-x86_64-apple-darwin.tar.xz"
      sha256 "5ad70427e7bcfddb76523f10564e4d3d4a34016e76ac95ebfc20aea8af13b9e3"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nrev/releases/download/v0.1.0/nrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a969901be1d040b19e8e2b4a696b8ad75ca2c62c835715bfcd6db8d8c4df567"
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
      bin.install "nrev"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "nrev"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "nrev"
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
