# Homebrew formula for Kue.
#
# Canonical home: this file is the source of truth, but `brew install` reads it
# from a TAP repository, not from here. It must be published to
# `chakrit/homebrew-tap` at path `Formula/kue.rb` for `brew install
# chakrit/tap/kue` to work. See
# docs/notes/2026-06-16-release-and-homebrew-setup.md for the publish steps.
#
# The `kue` binary is self-contained (Lean's runtime is linked statically; only
# system libs remain dynamic), so we ship the prebuilt release asset per
# platform and install it directly. Three assets are published per release:
#
#   macOS arm64   kue-aarch64-apple-darwin       (built by scripts/release.sh)
#   Linux x86_64  kue-x86_64-unknown-linux-gnu   (built by scripts/release-linux.sh)
#   Linux arm64   kue-aarch64-unknown-linux-gnu  (built by scripts/release-linux.sh)
#
# On each release, bump `version` and the url/sha256 inside each platform block.
# Each sha256 is the checksum of the matching release asset:
#   shasum -a 256 <asset>
class Kue < Formula
  desc "Lean 4 reimplementation of the CUE language"
  homepage "https://github.com/chakrit/kue"
  license "MIT"
  version "0.1.0-alpha.20260705.1"

  on_macos do
    on_arm do
      url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260705.1/kue-aarch64-apple-darwin"
      sha256 "b09c4e966d1108f35e0b3807e3e314901a5954ba658218bf6419e20566bb2f36"

      def install
        bin.install "kue-aarch64-apple-darwin" => "kue"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260705.1/kue-x86_64-unknown-linux-gnu"
      sha256 "8be0a7c048885c16012678e83b6f4cb026ca64ae77693c466ec006fa66bf049c"

      def install
        bin.install "kue-x86_64-unknown-linux-gnu" => "kue"
      end
    end

    on_arm do
      url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260705.1/kue-aarch64-unknown-linux-gnu"
      sha256 "60d167c117ac328f7891dc47dabaa910c1fc66efd3e9ff3ec05fee5c7ede3ba0"

      def install
        bin.install "kue-aarch64-unknown-linux-gnu" => "kue"
      end
    end
  end

  test do
    assert_equal "x: 1", pipe_output("#{bin}/kue", "x: int & 1\n").strip
  end
end
