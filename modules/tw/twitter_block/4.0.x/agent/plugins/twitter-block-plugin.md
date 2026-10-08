<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `twitter_block` Block plugin

`Drupal\twitter_block\Plugin\Block\TwitterBlock` — the only plugin the module provides.
The module defines **no plugin type of its own**; this is a plain core Block plugin you
place, not extend.

```php
#[Block(
  id: "twitter_block",
  admin_label: "Twitter block",
  category: "Twitter",
)]
```

(Declared via the `@Block` annotation in source; id `twitter_block`.) It extends
`BlockBase` and implements `ContainerFactoryPluginInterface`, injecting
`language_manager` (used to emit the current interface language when no explicit
`language` is set).

## What it renders

`build()` returns a single `#type => link` render element:

- title `Tweets by @{username}`, url `https://twitter.com/{username}`;
- class `twitter-timeline`;
- `#attached` library `twitter_block/widgets`, which loads
  `//platform.twitter.com/widgets.js` (external, async) — that script turns the link
  into the live embedded timeline client-side.

Each non-empty setting is emitted as a `data-*` (or aria/lang) attribute on the link:

| Setting | Emitted attribute |
|---|---|
| `theme` | `data-theme` |
| `link_color` | `data-link-color` = `#` + value |
| `width` | `data-width` |
| `height` | `data-height` |
| `chrome` (checked keys) | `data-chrome` = space-separated keys |
| `border_color` | `data-border-color` = `#` + value |
| `language` (else current lang) | `lang` |
| `tweet_limit` | `data-tweet-limit` |
| `dnt` (if TRUE) | `data-dnt` = `true` |
| `related` | `data-related` |
| `polite` | `aria-live` |

## Form / submit

`blockForm()` builds the fields documented in
[../configure/block-settings.md](../configure/block-settings.md) (username is `#required`).
`blockSubmit()` saves `username` plus every value from the `appearance`, `functionality`,
`size`, and `accessibility` fieldsets via `setConfigurationValue()`.

## Extending

To customise output, create your own Block plugin (optionally subclassing `TwitterBlock`)
and override `build()`; there are no hooks or plugin-type extension points in this module.
