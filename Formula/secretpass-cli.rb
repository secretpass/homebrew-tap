class SecretpassCli < Formula
  desc "Secretpass cli allows you to manage secrets locally secured through passkeys for human access and generated private keys for machine access"
  homepage "https://secretpass.cloud"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b30ce653b60a5e0b46f72f4a14c1caab94e0bfce277c8e7f4012787dbc8f974f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4a9e3ddbfd1b440f94718f040d477bfbd831bdbbbb54795d699e58726f1946fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "416d00571b96980b15a4390afd5eff2aa0a4e33f880aa2d96b5e0e1ceb16ae68"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/cli/releases/download/0.2.3/secretpass-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c342091636c6b0618f1304b88e2d0c4284ee831a7f518560467d929e4a1375ec"
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
