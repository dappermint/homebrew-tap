cask "fastpotify" do
  version "0.1.3"
  sha256 "70aaaa8ab43359ab043c5d6c4820e54d7f92499982545ef6a815e13e05609a26"

  url "https://github.com/crmne/fastpotify/releases/download/v#{version}/fastpotify-v#{version}-macos-universal.dmg",
      verified: "github.com/crmne/fastpotify/"
  name "Fastpotify"
  desc "Native Spotify client and Spotify Connect receiver"
  homepage "https://fastpotify.rocks/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Fastpotify.app"

  postflight do
    # Upstream builds are ad-hoc signed and not notarized, so clear quarantine
    # to avoid Gatekeeper blocking launch.
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Fastpotify.app"]
  end

  uninstall quit: "me.paolino.fastpotify"

  zap trash: [
    "~/Library/Application Support/me.paolino.fastpotify",
    "~/Library/Caches/me.paolino.fastpotify",
    "~/Library/Preferences/me.paolino.fastpotify.plist",
    "~/Library/Saved Application State/me.paolino.fastpotify.savedState",
  ]
end
