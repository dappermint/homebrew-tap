cask "shyfoss" do
  version "0.3.0"
  sha256 "0211ca3ef4fb196dbe42ef59d8cd6271eb3d0ce7f8e510a9b39f60b7b3765d90"

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
