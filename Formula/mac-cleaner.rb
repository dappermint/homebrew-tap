class MacCleaner < Formula
  desc "Whole-surface macOS storage accounting and cleanup TUI"
  homepage "https://github.com/dappermint/mac-cleaner"
  url "https://github.com/dappermint/mac-cleaner/archive/refs/tags/v0.88.0.tar.gz"
  sha256 "c41b193fb6981fa608bed7029e849984f1902dae9c1685e916590e0b51a99fbf"
  license "GPL-3.0-only"
  head "https://github.com/dappermint/mac-cleaner.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/mac-cleaner"
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mac-cleaner version")
    assert_match "usage:", shell_output("#{bin}/mac-cleaner help")
  end
end
