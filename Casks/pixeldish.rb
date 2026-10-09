cask "pixeldish" do
  version "0.3.0"
  sha256 "80a9ebdad07f8a4d46bd0bccdc24d4705c7c9c709fed3729619d73c16f558495"

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

  zap trash: "~/Library/Preferences/lgbt.dappy.pixeldish.plist"
end
