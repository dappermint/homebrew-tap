cask "fluxer@canary" do
  version "2026.821.153243"
  sha256 "16b4d61435ea30ba0969b1544bdcab6c1407971e02aa1be11b1543d9e4850e47"

  # The arm64 and x64 paths both hand back the same universal dmg.
  url "https://api.fluxer.app/dl/desktop/canary/darwin/arm64/#{version}/dmg",
      verified: "api.fluxer.app/"
  name "Fluxer Canary"
  desc "Chat, voice and video client for friends and communities"
  homepage "https://fluxer.app/"

  livecheck do
    url "https://api.fluxer.app/dl/desktop/canary/darwin/arm64/latest/dmg"
    regex(/Fluxer(?:%20|\s)Canary[._-]v?(\d+(?:\.\d+)+)-mac/i)
    strategy :header_match
  end

  auto_updates true
  depends_on macos: :monterey

  app "Fluxer Canary.app"

  uninstall quit: "app.fluxer.canary"

  zap trash: [
    "~/Library/Application Support/Fluxer Canary",
    "~/Library/Caches/app.fluxer.canary",
    "~/Library/Caches/app.fluxer.canary.ShipIt",
    "~/Library/HTTPStorages/app.fluxer.canary",
    "~/Library/Preferences/app.fluxer.canary.plist",
    "~/Library/Saved Application State/app.fluxer.canary.savedState",
  ]
end
