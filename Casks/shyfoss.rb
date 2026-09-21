cask "shyfoss" do
  version "0.3.1"
  sha256 "7d99526c39b71f0ee5dbe41fc327236c7c45fc07bd8cc878207b8a145b3cbb12"

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
