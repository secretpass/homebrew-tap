class SecretpassCli < Formula
  desc "Secretpass cli allows you to manage secrets locally secured through passkeys for human access and generated private keys for machine access"
  homepage "https://secretpass.cloud"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.2.1/secretpass-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9b22670f4cdaa9cf90607c0668b84aa3077b0853d20f9f0dee2173119f1c9041"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.2.1/secretpass-cli-x86_64-apple-darwin.tar.xz"
      sha256 "df1466e25ad7ebe0f159593f15a6e69181b3efea9fb20dcbf2a1538d65b526a0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.2.1/secretpass-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c0c54770ff0ac9e176f775425221b90c6cd0e8e221e6dab310b72fdbbacd3b78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.2.1/secretpass-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2a918f88202b8e44b9384b8933c62a6a69ddf5f2723873a1d14ecf1c8c39572f"
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
