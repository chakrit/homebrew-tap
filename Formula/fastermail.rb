# Homebrew formula for fastermail (the `fm` binary).
#
# Canonical home: this file is the source of truth, but `brew install` reads it
# from the TAP repository (`chakrit/homebrew-tap`) at path
# `Formula/fastermail.rb`, for `brew install chakrit/tap/fastermail` to work.
#
# We ship the prebuilt macOS arm64 release asset and install it directly. Other
# platforms are served by the GitHub release assets + scripts/install.sh in the
# fastermail repo.
#
# On each release, `scripts/release.sh` in the fastermail repo patches the
# `version`, `url`, and `sha256` lines below. The sha256 is the checksum of the
# `fm-aarch64-apple-darwin` release asset:
#   shasum -a 256 fm-aarch64-apple-darwin
class Fastermail < Formula
  desc "FastMail CLI and MCP server (JMAP) — email, contacts, masked email"
  homepage "https://github.com/chakrit/fastermail"
  license "MIT"
  version "0.1.0"

  url "https://github.com/chakrit/fastermail/releases/download/v0.1.0/fm-aarch64-apple-darwin"
  sha256 "a66f68bde93a6fc674a4103bfe1601631ad2705b1922b35234d34a04376ba191"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "fm-aarch64-apple-darwin" => "fm"
  end

  test do
    assert_match "fm", shell_output("#{bin}/fm --version")
  end
end
