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
  version "0.1.0-alpha.20260702"

  on_macos do
    on_arm do
      url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260702/kue-aarch64-apple-darwin"
      sha256 "072f93999864b877df0e529c8b7272217f70ccba5e58247cddc86fa2d4a33f06"

      def install
        bin.install "kue-aarch64-apple-darwin" => "kue"
      end
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260624/kue-x86_64-unknown-linux-gnu"
      sha256 "9e97a2a1fce2c8a9634f86e7a8bf75597cb65c481d4e06848f475bb87cd23e78"

      def install
        bin.install "kue-x86_64-unknown-linux-gnu" => "kue"
      end
    end

    on_arm do
      url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260624/kue-aarch64-unknown-linux-gnu"
      sha256 "b4f85da3621dbfb86a625bd07b8eb270feea3a1ecc93f15c062c64fc92f2571e"

      def install
        bin.install "kue-aarch64-unknown-linux-gnu" => "kue"
      end
    end
  end

  test do
    assert_equal "x: 1", pipe_output("#{bin}/kue", "x: int & 1\n").strip
  end
end
