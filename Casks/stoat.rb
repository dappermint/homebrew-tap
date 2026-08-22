cask "stoat" do
  arch arm: "arm64", intel: "x64"

  version "1.5.3"
  sha256 arm:   "ec031ea68abae09acebcad9135879ec33917be01fcb10bbb691f458b9103236d",
         intel: "342922602d21243dfb24a28551d696d5101ee4fb0426d2540d720df8158031a3"

  url "https://github.com/stoatchat/for-desktop/releases/download/v#{version}/Stoat-darwin-#{arch}-#{version}.zip",
      verified: "github.com/stoatchat/for-desktop/"
  name "Stoat"
  desc "Community-oriented chat client"
  homepage "https://stoat.chat/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # It ships Squirrel and a RELEASES feed, but the builds are ad-hoc signed with
  # no team identifier, so anything ShipIt drops in place comes back quarantined
  # and refuses to launch. Brew owns upgrades instead, which re-runs the
  # postflight below on every version.
  auto_updates false
  depends_on macos: :monterey

  app "Stoat.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Stoat.app"]
  end

  uninstall quit: "com.electron.stoat"

  zap trash: [
    "~/Library/Application Support/stoat-desktop",
    "~/Library/Caches/com.electron.stoat",
    "~/Library/Caches/com.electron.stoat.ShipIt",
    "~/Library/HTTPStorages/com.electron.stoat",
    "~/Library/Preferences/com.electron.stoat.plist",
    "~/Library/Saved Application State/com.electron.stoat.savedState",
  ]
end
