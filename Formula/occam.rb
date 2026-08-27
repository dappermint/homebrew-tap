class Occam < Formula
  desc "Control a Razer BlackShark V3 Pro from macOS, without Synapse"
  homepage "https://github.com/dappermint/occam"
  url "https://github.com/dappermint/occam/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "42cadf0c109ac840661ffdb0953561b841d3086b0588f54a6cbe2c20b21e11e7"
  license "MIT"
  head "https://github.com/dappermint/occam.git", branch: "main"

  depends_on "go" => :build
  # occmixer is Rust: the DSP runs inside a CoreAudio render callback, where a
  # garbage collector cannot go.
  depends_on "rust" => :build
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
    system "go", "build", *std_go_args(output: bin/"occam-spatial"), "./cmd/occam-spatial"

    cd "occmixer" do
      system "cargo", "install", *std_cargo_args
    end

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

      Two more binaries come with it. occam-spatial renders a file to
      binaural; occmixer does the same to system audio as it plays, and the
      Spatial tab of the settings window turns it on and off.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/occam version")

    # The EQ library is compiled in, so this needs no hardware.
    assert_match "Valorant", shell_output("#{bin}/occam presets valorant")

    # Frame building is pure, so the encoder is exercised without a device.
    assert_match "setCustomerEQBand",
                 shell_output("#{bin}/occam eq --preset Game --slot 0 --dry-run")

    # Both renderers answer for themselves without a device attached.
    assert_match "binaural", shell_output("#{bin}/occam-spatial --help")
    assert_match "binaural", shell_output("#{bin}/occmixer --help")
  end
end
