cask "pixeldish" do
  version "0.4.0"
  sha256 "c1dd309895eea4a0fce8736d0b3ad0235d558f00900d2b66eddb32d1e5afa303"

  url "https://github.com/dappermint/pixeldish/releases/download/v#{version}/Pixeldish-#{version}.dmg"
  name "Pixeldish"
  desc "Dithered procedural wallpapers"
  homepage "https://github.com/dappermint/pixeldish"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Pixeldish.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Pixeldish.app"]
  end

  uninstall quit: "lgbt.dappy.pixeldish"

  zap trash: [
    "~/Library/Application Support/Pixeldish",
    "~/Library/Preferences/lgbt.dappy.pixeldish.plist",
    "~/Library/Screen Savers/Pixeldish.saver",
  ]
end
