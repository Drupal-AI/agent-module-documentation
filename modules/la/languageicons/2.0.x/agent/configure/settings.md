<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Language Icons

Settings form: **`/admin/config/regional/language/icons`** (route `languageicons.settings`,
menu under *Configuration → Regional and language*). Permission: core **`administer
languages`**. Config object: **`languageicons.settings`**.

## Config keys (`languageicons.settings`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `placement` | string | `before` | Icon position vs. link text: `before`, `after`, or `replace` (show only the flag, hide the text). |
| `size` | string | `16x12` | Icon size as `WIDTHxHEIGHT`; split on `x` and applied as the image `#width`/`#height`. |
| `path` | string | module `flags/*.png` | Glob-style path to the icon files; `*` is replaced by the language code. Set on install to `<module path>/flags/*.png`. |
| `show_node` | bool | `true` | Legacy flag "add icons to node links". |
| `show_block` | bool | `true` | Legacy flag "add icons to the language switcher block". |

`show_node` / `show_block`: the checkboxes for these are **disabled** in the settings form
(upstream bug node/1005144). Icons are added to language switch links when
`show_block` **or** `show_node` is truthy — which is the default — so in practice icons show
on the switcher block regardless.

## Read / set via drush

```bash
drush config:get languageicons.settings
drush config:set languageicons.settings placement replace -y   # flag only, no text
drush config:set languageicons.settings size 24x18 -y
drush config:set languageicons.settings path 'sites/default/files/flags/*.png' -y
```

## The Language switcher block

The icons only appear where language links are rendered. Enable the core **Language switcher**
block (Interface text language detection) and place it in a visible region
(`/admin/structure/block`). View any page; each language link gets a flag.

## Requirements

- Core `locale` module (declared dependency) and at least two configured languages.
- The default flag set is 12px-tall PNGs; override `path`/`size` for a custom set.
