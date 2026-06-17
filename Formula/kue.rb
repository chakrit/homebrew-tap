# Homebrew formula for Kue.
#
# Canonical home: this file is the source of truth, but `brew install` reads it
# from a TAP repository, not from here. It must be published to
# `chakrit/homebrew-tap` at path `Formula/kue.rb` for `brew install
# chakrit/tap/kue` to work. See
# docs/notes/2026-06-16-release-and-homebrew-setup.md for the publish steps.
#
# The `kue` binary is self-contained on macOS arm64 (Lean's runtime is linked
# statically; only /usr/lib system libs remain dynamic), so we ship the
# prebuilt release asset and install it directly.
#
# On each release, bump `version`, `url`, and `sha256`. The sha256 is the
# checksum of the `kue-aarch64-apple-darwin` release asset:
#   shasum -a 256 kue-aarch64-apple-darwin
class Kue < Formula
  desc "Lean 4 reimplementation of the CUE language"
  homepage "https://github.com/chakrit/kue"
  license "MIT"
  version "0.1.0-alpha.20260617.3"

  url "https://github.com/chakrit/kue/releases/download/v0.1.0-alpha.20260617.3/kue-aarch64-apple-darwin"
  sha256 "d07d99f2a2a0de0a27f5e4b27913812451c9f02b6bff804e82484e85bef0547a"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "kue-aarch64-apple-darwin" => "kue"
  end

  test do
    assert_equal "x: 1", pipe_output("#{bin}/kue", "x: int & 1\n").strip
  end
end
