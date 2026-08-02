class MacCleaner < Formula
  desc "Whole-surface macOS storage accounting and cleanup TUI"
  homepage "https://github.com/dappermint/mac-cleaner"
  url "https://github.com/dappermint/mac-cleaner/archive/refs/tags/v0.89.1.tar.gz"
  sha256 "4ef10890d7e6f10f54052c80ff02de86760f93576ee688e3697f7b4932b93dee"
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
