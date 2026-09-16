cask "thaw@alpha" do
  version "3.0.0-alpha.5"
  sha256 "48740fe028de1fdcbedbc68c0bfbd92f8bd385e7cba5c905460265339813a4f4"

  url "https://github.com/thaw-app/Thaw/releases/download/#{version}/Thaw_#{version}.zip"
  name "Thaw"
  desc "Menu bar manager"
  homepage "https://github.com/thaw-app/Thaw/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+-alpha[._-]?\d+(?:\.\d+)*)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"]

        match = release["tag_name"]&.match(regex)
        next if match.blank?

        match[1]
      end
    end
  end

  auto_updates true
  conflicts_with cask: [
    "thaw",
    "thaw@beta",
  ]
  depends_on macos: :golden_gate

  app "Thaw.app"

  uninstall quit: [
    "com.stonerl.Thaw",
    "com.stonerl.Thaw.MenuBarCaptureService",
  ]

  zap trash: [
    "~/Library/Caches/com.stonerl.Thaw",
    "~/Library/HTTPStorages/com.stonerl.Thaw",
    "~/Library/Preferences/com.stonerl.Thaw.plist",
    "~/Library/WebKit/com.stonerl.Thaw",
  ]
end
