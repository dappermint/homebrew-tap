class Occam < Formula
  desc "Control a Razer BlackShark V3 Pro from macOS, without Synapse"
  homepage "https://github.com/dappermint/occam"
  url "https://github.com/dappermint/occam/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "beef912d292c2c14977fae2b34075e68acd3d5693468313192443245d24909b0"
  license "MIT"
  head "https://github.com/dappermint/occam.git", branch: "main"

  depends_on "go" => :build
  # cgo against IOKit, CoreFoundation and Cocoa. There is no Linux path.
  depends_on :macos

  def install
    # output is pinned so the binary name never follows the formula name.
    system "go", "build", *std_go_args(output:  bin/"occam",
                                       ldflags: "-X github.com/dappermint/occam/cmd.version=#{version}")
    doc.install "README.md", "docs/protocol.md", "docs/design.md"
  end

  # Runs the menu bar app, which also re-applies the saved profile whenever the
  # dongle reconnects. keep_alive is deliberately false: quitting from the menu
  # should quit rather than be resurrected a second later.
  service do
    run [opt_bin/"occam", "menu"]
    run_type :immediate
    keep_alive false
    log_path var/"log/occam.log"
    error_log_path var/"log/occam.err"
  end

  def caveats
    <<~EOS
      occam needs no permissions, not even from the menu bar agent.

      Start it at login:
        brew services start occam

      Save the headset's current settings so they survive a reconnect:
        occam save --all
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/occam version")

    # The EQ library is compiled in, so this needs no hardware.
    assert_match "Valorant", shell_output("#{bin}/occam presets valorant")

    # Frame building is pure, so the encoder is exercised without a device.
    assert_match "setCustomerEQBand",
                 shell_output("#{bin}/occam eq --preset Game --slot 0 --dry-run")
  end
end
