# homebrew-tap

Homebrew formulae and casks for [dappermint](https://github.com/dappermint)'s tools.

```sh
brew tap dappermint/tap
brew install mac-cleaner

brew trust --cask dappermint/tap/whisky-preview
brew install --cask whisky-preview
```

Casks need `brew trust` first: Homebrew refuses to load one from a third-party
tap until you trust it, because a cask can run code on install.

Or in one step, without tapping first:

```sh
brew install dappermint/tap/mac-cleaner
```

## formulae

| formula | what it is |
| --- | --- |
| [mac-cleaner](https://github.com/dappermint/mac-cleaner) | Whole-surface macOS storage accounting and cleanup TUI |

Formulae here are published automatically by [goreleaser](https://goreleaser.com)
when the upstream project is tagged, so they track releases rather than being
edited by hand.

## casks

| cask | what it is |
| --- | --- |
| [whisky-preview](https://github.com/dappermint/Whisky) | Development fork of Whisky, a Wine wrapper for running Windows apps |

Whisky Preview is ad-hoc signed and not notarized, so the cask clears the
quarantine flag on install. It uses its own bundle identifier and installs as
`Whisky Preview.app`, so it sits beside a normal Whisky rather than replacing it.
