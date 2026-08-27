class Occam < Formula
  desc "Control a Razer BlackShark V3 Pro from macOS, without Synapse"
  homepage "https://github.com/dappermint/occam"
  url "https://github.com/dappermint/occam/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "0c5724595db919fd60ab2f9818cd945fd8e4185f66a037fadd777a99845ad70e"
  license "MIT"
  head "https://github.com/dappermint/occam.git", branch: "main"

  depends_on "go" => :build
  # cgo against IOKit, CoreFoundation and Cocoa. There is no Linux path.
  depends_on :macos

  def install
    # The macOS 26+ appearance, Liquid Glass included, is gated on the SDK a
    # binary links against rather than on anything the code does, so build
    # against the newest one present instead of whatever is on the path.
    if (sdk = MacOS.sdk_path_if_needed || MacOS.sdk&.path)
      ENV["CGO_CFLAGS"] = "-isysroot #{sdk} -mmacosx-version-min=14.0"
      ENV["CGO_LDFLAGS"] = "-isysroot #{sdk} -mmacosx-version-min=14.0"
    end

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
