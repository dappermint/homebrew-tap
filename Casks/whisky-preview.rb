cask "whisky-preview" do
  version "2026.8.46"
  sha256 "4aa1a58ecc18e93bd96ef66727b5ebb84d30c874741b05d2712cdb0ea6f0f7d8"

  url "https://github.com/dappermint/Whisky/releases/download/app-v#{version}/Whisky-Preview-#{version}.dmg",
      verified: "github.com/dappermint/Whisky/"
  name "Whisky Preview"
  desc "Development fork of Whisky, a Wine wrapper for running Windows apps"
  homepage "https://github.com/dappermint/Whisky"

  livecheck do
    url :url
    # The repo also publishes bare vX.Y.Z tags for the Wine runtime, which carry no
    # cask, so match the app stream's tags only rather than taking the latest release.
    regex(/^app-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  # No in-app updater: the Sparkle feed was removed along with the fork's tie to
  # upstream's signing key, so brew owns upgrades.
  auto_updates false
  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Whisky Preview.app"

  postflight do
    # Self-signed and not notarized, so a quarantined copy is refused outright
    # and macOS offers no way to approve it. Homebrew's --no-quarantine would do
    # the same, but silently failing to launch for anyone who forgets the flag is
    # worse than clearing it here.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Whisky Preview.app"]
  end

  uninstall quit: "com.dappermint.WhiskyPreview"

  # Bottles live in the container, so a zap can discard a lot of installed games.
  # trash: rather than delete: keeps that recoverable.
  zap trash: [
    "~/Library/Application Support/com.dappermint.WhiskyPreview",
    "~/Library/Caches/com.dappermint.WhiskyPreview",
    "~/Library/Containers/com.dappermint.WhiskyPreview",
    "~/Library/HTTPStorages/com.dappermint.WhiskyPreview",
    "~/Library/Preferences/com.dappermint.WhiskyPreview.plist",
    "~/Library/Saved Application State/com.dappermint.WhiskyPreview.savedState",
  ]
end
