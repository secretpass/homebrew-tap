class SecretpassCloud < Formula
  desc "Secretpass cli allows you to manage secrets locally secured through passkeys for human access and generated private keys for machine access"
  homepage "https://secretpass.cloud"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cloud-aarch64-apple-darwin.tar.xz"
      sha256 "de7af47dddc013e6e29d07615b04c0dc2f4ea06a9ea3bc7ecc24d21160eb2a0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cloud-x86_64-apple-darwin.tar.xz"
      sha256 "63a192cf4ba20f33f2e811e2362099296f3eb642b8c731a0421871eac61a3bad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cloud-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "970bd1f0180d6bd0bf28de38826d6e4be8f305339a27364e90fe7fa443c50d4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/secretpass/core/releases/download/0.1.2/secretpass-cloud-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "56d329aa533a93f9c83d5ad6571d7e8580ec203f124bacf4f681b4a66d409f46"
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
      bin.install "secretpass-cloud"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "secretpass-cloud"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "secretpass-cloud"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "secretpass-cloud"
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
