cask "shyfoss" do
  version "0.1.0"
  sha256 "e91bca1644625ac98e47fbfb69be612ba6c5b2602757860a5d3f014f2fb4c3dd"

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
