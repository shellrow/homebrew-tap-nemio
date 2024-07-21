class Nrev < Formula
  desc "Simple and Fast Network Revealer/Mapper."
  homepage "https://github.com/shellrow/nrev"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shellrow/nrev/releases/download/v0.3.0/nrev-aarch64-apple-darwin.tar.xz"
      sha256 "05a4fe495993a50922c4c503840feb5d3eac1c1c43191bdbd39741a0493e1522"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nrev/releases/download/v0.3.0/nrev-x86_64-apple-darwin.tar.xz"
      sha256 "70133ab803e1c0950d371d983de92c84304231339c46bd2356b9e2779d322288"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nrev/releases/download/v0.3.0/nrev-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0084dd01ee6f41158e1ad78cec0fd8a23fd56ca6b276ffa4c116714ce59dc47b"
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
