class Nemio < Formula
  desc "Simple and Fast Network Mapper"
  homepage "https://github.com/shellrow/nemio"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/shellrow/nemio/releases/download/v0.1.0/nemio-aarch64-apple-darwin.tar.xz"
      sha256 "0c7a8bd3b812f6ffc3792d73bac33965a16258a3c929f9d47eeb240536c38df9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nemio/releases/download/v0.1.0/nemio-x86_64-apple-darwin.tar.xz"
      sha256 "e42a8ede2cea147522b925b99495e7f9be1e7500de5a05ca6b26f5e66ae73b62"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/shellrow/nemio/releases/download/v0.1.0/nemio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd50836ec4218ad33c43988a5867df0315ae8acc724d14decdd6792c48cdd7c2"
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
