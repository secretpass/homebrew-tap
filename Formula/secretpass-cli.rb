class SecretpassCli < Formula
  desc "Secretpass cli allows you to manage secrets locally secured through passkeys for human access and generated private keys for machine access"
  homepage "https://secretpass.cloud"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-aarch64-apple-darwin.tar.xz"
      sha256 "443167ff6c8c8c19b51127a07efe8ddfec8855145abf3162ca912484d57d09c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-x86_64-apple-darwin.tar.xz"
      sha256 "8da7022869a1713e001f76f8dabf31aedd704a7b5a8eaceef4f8950d390e2990"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "997f223436081ca5ecfce4af6ae2a3e5c63c2422bb58e0aac84872e648526c01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f2effda42203f3a32a36e3da12dc78410d5bf8c84467221b22dbb62bd880933"
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
