cask "snoop" do
  version "0.1.3"
  sha256 "9b4c80c51df9f337316efb83b1f232620e4339d6ee68122d5fe260d110537ee9"

  url "https://github.com/dappermint/snoop/releases/download/v#{version}/snoop-v#{version}-macos-universal.dmg",
      verified: "github.com/dappermint/snoop/"
  name "Snoop"
  desc "Spotify client and Spotify Connect receiver"
  homepage "https://github.com/dappermint/snoop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Snoop.app"

  postflight do
    # Ad-hoc signed and not notarized, so clear quarantine to avoid Gatekeeper blocking launch.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Snoop.app"]
  end

  uninstall quit: "com.dappermint.snoop"

  zap trash: [
    "~/Library/Application Support/com.dappermint.snoop",
    "~/Library/Caches/com.dappermint.snoop",
    "~/Library/Preferences/com.dappermint.snoop.plist",
    "~/Library/Saved Application State/com.dappermint.snoop.savedState",
  ]
end
