class Maccordion < Formula
  desc "Play your MacBook like an accordion, using the lid angle sensor as bellows"
  homepage "https://github.com/dappermint/maccordion"
  url "https://github.com/dappermint/maccordion/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ce62c8bd39ab7b7a212ce558b7e182a68ea1ad5f7cce4797e2161453b33ac0d3"
  license "MIT"
  head "https://github.com/dappermint/maccordion.git", branch: "main"

  depends_on "rust" => :build
  # Reads the lid angle over raw HID and renders through CoreAudio.
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  def caveats
    <<~EOS
      maccordion needs no permissions: the lid angle sensor is a plain HID
      feature report and audio goes through the default output device.

      The lid is the bellows, so the instrument only sounds while the lid is
      actually moving, the same way a real one only sounds while you pump it.
      Hold SPACE for a hands-free bellows if you would rather keep the lid
      still, or UP/DOWN to push and pull by hand.

      Not every MacBook has the sensor. Without one it starts in keyboard
      mode and says so in the window.
    EOS
  end

  test do
    # The synth, bellows physics and key layout all answer without a device;
    # the audio and HID paths need hardware, so they are not exercised here.
    assert_match "maccordion", shell_output("#{bin}/maccordion --help 2>&1")
  end
end
