class MacCleaner < Formula
  desc "Whole-surface macOS storage accounting and cleanup TUI"
  homepage "https://github.com/dappermint/mac-cleaner"
  url "https://github.com/dappermint/mac-cleaner/archive/refs/tags/v0.89.2.tar.gz"
  sha256 "80d93626361ac9d967ae60456798cc67d4921e1daefbc91a727a55204ceca013"
  license "GPL-3.0-only"
  head "https://github.com/dappermint/mac-cleaner.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}"), "./cmd/mac-cleaner"
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mac-cleaner version")
    assert_match "usage:", shell_output("#{bin}/mac-cleaner help")
  end
end
