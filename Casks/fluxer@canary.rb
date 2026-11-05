cask "fluxer@canary" do
  version "2026.1105.25346"
  sha256 "ab284fa69c268dbd04a6cc73d1023e8db16e988eab1fc140ff3451b9deb1142a"

  # The arm64 and x64 paths both hand back the same universal dmg.
  url "https://api.fluxer.app/dl/desktop/canary/darwin/arm64/#{version}/dmg"
  name "Fluxer Canary"
  desc "Chat, voice and video client for friends and communities"
  homepage "https://fluxer.app/"

  livecheck do
    url "https://api.fluxer.app/dl/desktop/canary/darwin/arm64/latest/dmg"
    regex(/Fluxer(?:%20|[\s_-])Canary[._-]v?(\d+(?:\.\d+)+)-mac/i)
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
