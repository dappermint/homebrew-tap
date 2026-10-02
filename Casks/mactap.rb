cask "mactap" do
  version "2.1.2"
  sha256 "6abda22fabaf0fd79518f9006271f1ea570c0d4418a46666b7f3e062de5da636"

  url "https://github.com/jaskirat1616/mactap-app/releases/download/v#{version}/MacTap-#{version}.zip"
  name "MacTap"
  desc "Knock your MacBook to run shortcuts"
  homepage "https://mactap.vercel.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "MacTap.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/MacTap.app"]
  end

  uninstall quit: "app.mactap.MacTap"

  zap trash: [
    "~/Library/Preferences/app.mactap.MacTap.plist",
  ]
end
