class SecretpassCli < Formula
  desc "Secretpass cli allows you to manage secrets locally secured through passkeys for human access and generated private keys for machine access"
  homepage "https://secretpass.cloud"
  version "0.1.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.1.16/secretpass-cli-aarch64-apple-darwin.tar.xz"
      sha256 "eec7e508dd87ce0e3bbb322965238643328051ab318dcf093f6acb46ce05ba19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.1.16/secretpass-cli-x86_64-apple-darwin.tar.xz"
      sha256 "063b4bf39c86ece7088ec686a19da9ec9dafd8a1a016e4fa2f1d215fab908503"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.1.16/secretpass-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a7c7410bd3c932cc53bf2b6dc7d8a0e3ee8b5d0d32adc66f90dc4619d3b232f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.1.16/secretpass-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "04f219b4a0fcf5efbf6ec8fb503e50725999a259c0b3c56269985cc4495dbd33"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {
      spass: [
        "secretpass",
      ],
    },
    "aarch64-unknown-linux-gnu":         {
      spass: [
        "secretpass",
      ],
    },
    "x86_64-apple-darwin":               {
      spass: [
        "secretpass",
      ],
    },
    "x86_64-unknown-linux-gnu":          {
      spass: [
        "secretpass",
      ],
    },
    "x86_64-unknown-linux-musl-dynamic": {
      spass: [
        "secretpass",
      ],
    },
    "x86_64-unknown-linux-musl-static":  {
      spass: [
        "secretpass",
      ],
    },
  }.freeze

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
      bin.install "spass"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "spass"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "spass"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "spass"
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
