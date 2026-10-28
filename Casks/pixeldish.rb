cask "pixeldish" do
  version "0.6.0"
  sha256 "bb25e22cfcfb9a193e59d9a19ee035eb49ef1750503257c68c9f3d03080a8141"

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
    "~/.config/pixeldish",
    "~/Library/Application Support/Pixeldish",
    "~/Library/Preferences/lgbt.dappy.pixeldish.plist",
    "~/Library/Screen Savers/Pixeldish.saver",
  ]
end
