cask "pixeldish" do
  version "0.3.1"
  sha256 "23fe1ff88b67f85210bfe31a1f79c9237ef60d7f8cf35076201c7a197d40c43d"

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
