cask "sideloadly" do
  version "0.60.0"
  sha256 :no_check

  url "https://sideloadly.io/SideloadlySetup.dmg"
  name "Sideloadly"
  desc "Sideload iOS apps onto iPhone, iPad and Apple Silicon Macs"
  homepage "https://sideloadly.io/"

  livecheck do
    url :homepage
    regex(/"softwareVersion":\s*"(\d+(?:\.\d+)+)"/i)
  end

  depends_on macos: :big_sur

  app "Sideloadly.app"

  postflight_steps do
    # Unsigned and not notarized, so clear quarantine to avoid Gatekeeper blocking launch.
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Sideloadly.app"]
  end

  uninstall quit: "io.sideloadly.sideloadly"

  zap trash: [
    "~/Library/Preferences/io.sideloadly.sideloadly.plist",
    "~/Library/Saved Application State/io.sideloadly.sideloadly.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
