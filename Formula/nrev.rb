class Nrev < Formula
  desc "Simple and Fast Network Revealer/Mapper."
  homepage "https://github.com/shellrow/nrev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shellrow/nrev/releases/download/v0.2.0/nrev-aarch64-apple-darwin.tar.xz"
      sha256 "c61d3cd97b74b7d63470ee283c60a12b3fb5b3a1ccf4ab88c1882c0e66147fab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nrev/releases/download/v0.2.0/nrev-x86_64-apple-darwin.tar.xz"
      sha256 "75912f1f708b18f30c06a1e69c39f763e1dfc7f6cea78ac7bee69218d3ffb6d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nrev/releases/download/v0.2.0/nrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d5bf497f5de3295a646a9298909ccb24377e227f19a99c21f8674367fd6382f"
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
