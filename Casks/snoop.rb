cask "snoop" do
  version "0.6.0"
  sha256 "0b00604c38ade002fcedea1497aaec604919af38285c1606255924f240e2e708"

  url "https://github.com/dappermint/snoop/releases/download/v#{version}/snoop-v#{version}-macos-universal.dmg"
  name "Snoop"
  desc "Spotify client and Spotify Connect receiver"
  homepage "https://github.com/dappermint/snoop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Snoop.app"

  postflight_steps do
    # Ad-hoc signed and not notarized, so clear quarantine to avoid Gatekeeper blocking launch.
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Snoop.app"]
  end

  uninstall quit: "com.dappermint.snoop"

  zap trash: [
    "~/Library/Application Support/com.dappermint.snoop",
    "~/Library/Caches/com.dappermint.snoop",
    "~/Library/Preferences/com.dappermint.snoop.plist",
    "~/Library/Saved Application State/com.dappermint.snoop.savedState",
  ]
end
