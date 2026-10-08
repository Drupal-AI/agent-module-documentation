<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calimals (calimals) — agent index

An **animal-themed SVG icon pack** for the **UI Icons** module. Version **1.0.5**.
Package *User interface Icon packs*. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later.

Pure asset module: **no PHP, no routes, no permissions, no services, no hooks, no config schema,
no install file, no Drush.** Everything is one YAML pack definition plus SVG files.

- **The pack definition, the `size` setting, and how to use the icons** →
  [icons/pack.md](icons/pack.md)

## What it actually is

- One dependency: **`ui_icons`** (declared as `ui_icons:ui_icons` in `calimals.info.yml`). Without
  UI Icons enabled the icons do nothing.
- **`calimals.icons.yml`** defines a single icon pack `calimals` using the UI Icons built-in
  **`svg` extractor**, with `config.sources` globbing `/modules/contrib/calimals/icons/*.svg`.
- **`icons/*.svg`** — 33 static, maintainer-curated animal SVGs (alpaca, capricorn, capybara, cat,
  cow, dragon, duck, flamingo, frog, giraffe, hedgehog, hippo, kitten, lemur, lion, llama,
  monoceros, mouse, ostrich, panda, parrot, phoenix, pig, poulet, rabbit, red-panda, sheep,
  squirrel, teddy, toucan, unicorn, wildebeest, zebra). Each icon's machine id is its filename stem.
- The pack `settings.size` (integer, default **64**) and a Twig `template` control render output;
  default `viewBox` `0 0 2400 2400`, output `<svg>` carries `aria-hidden="true"` and classes
  `calimals` / `calimals--<icon_id>`.

## How to operate

- `drush en calimals -y` (UI Icons is pulled in as a dependency). No configuration form of its own.
- Icons then appear in any UI Icons picker and via the Twig `icon('calimals', '<id>', {size: 48})`
  usage — see [icons/pack.md](icons/pack.md).
