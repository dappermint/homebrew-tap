class MacCleaner < Formula
  desc "Whole-surface macOS storage accounting and cleanup TUI"
  homepage "https://github.com/dappermint/mac-cleaner"
  url "https://github.com/dappermint/mac-cleaner/archive/refs/tags/v0.89.0.tar.gz"
  sha256 "ef91a39cfc0061f5a2962676949fd2ab14cc5f7b8854cbf4e5c3327a8d44061a"
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
