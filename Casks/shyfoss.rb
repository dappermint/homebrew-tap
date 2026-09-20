cask "shyfoss" do
  version "0.3.0"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"

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
