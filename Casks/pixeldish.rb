cask "pixeldish" do
  version "0.5.3"
  sha256 "14edbe38d4296207fbf65c26a82228cb67b688eaa1be1d084b3e0ed5237cd18e"

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
