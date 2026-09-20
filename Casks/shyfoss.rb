cask "shyfoss" do
  version "0.2.0"
  sha256 "82cff177b786e869d13fb10cf9e7c294f8728a3bf8d67fc910f32568906227d4"

  url "https://github.com/dappermint/shyfoss/releases/download/v#{version}/ShyFoss-v#{version}.zip"
  name "ShyFoss"
  desc "Blur your Mac when you look away, using AirPods head tracking"
  homepage "https://github.com/dappermint/shyfoss"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "ShyFoss.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ShyFoss.app"]
  end

  uninstall quit: "lgbt.dappy.shyfoss"

  zap trash: "~/Library/Preferences/lgbt.dappy.shyfoss.plist"
end
