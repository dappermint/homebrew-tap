cask "pixeldish" do
  version "0.5.1"
  sha256 "d80a51729d9084c02dad2f052bef05c3a8a7e5935b39cef6b8f804bf1db17fde"

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
