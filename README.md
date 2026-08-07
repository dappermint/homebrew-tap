# homebrew-tap

Homebrew formulae and casks for [dappermint](https://github.com/dappermint)'s tools.

```sh
brew tap dappermint/tap
brew install mac-cleaner
brew install --cask whisky-preview
```

Or in one step, without tapping first:

```sh
brew install dappermint/tap/mac-cleaner
brew install --cask dappermint/tap/whisky-preview
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
