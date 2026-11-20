cask "pixeldish" do
  version "0.9.5"
  sha256 "0df88f8b31fc4d802d6c2d61a8296e344e011993c2c5bd474e6626085de1f45d"

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
