class SecretpassCli < Formula
  desc "Secretpass cli allows you to manage secrets locally secured through passkeys for human access and generated private keys for machine access"
  homepage "https://secretpass.cloud"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cli-aarch64-apple-darwin.tar.xz"
      sha256 "08e8be9aaacecfac6fb7cf797a90964a205ae39747475be61755c5e5e13eb9f6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3b3f0b94beebd35bfda8e78fb2662b9a70167653e944b9710c523f5f3a4687b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5e133270e74cba7e9ff3b0ce5cf1143a19b100db6146b6e91f10d2a7d5ab0ad7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e31ed4523d21171ed67faf5d64c481d308fb8b5c32b49fca3ff09f16318c0951"
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
