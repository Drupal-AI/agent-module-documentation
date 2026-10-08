<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flag icons Bootstrap CkEditor (bootstrap_flag_icons) — agent index

Presentational multilingual helper. Two independent features:
1. A **Bootstrap 5 language-switcher block** that re-themes core's language switcher as a flag dropdown.
2. A **CKEditor 5 plugin** for inserting flag icons (`<i class="fi …">`) into rich text.

No routes, no permissions, no services, no menu links, no config settings form. Flag styling comes from the `lipis/flag-icons` CSS library (bundled locally + a jsDelivr CDN fallback).

- **Package:** Multilingual · **License:** GPL-2.0-or-later · **Core:** `^9 || ^10 || ^11 || ^12`
- **Declared dependencies:** none in `.info.yml`. Soft-requires the core **language** module (block extends `Drupal\language\Plugin\Block\LanguageBlock`) and **ckeditor5** (plugin extends `CKEditor5PluginDefault`); the switcher only appears with multiple languages configured.
- **Config schema:** `config/schema/bootstrap_flag_icons.schema.yml` defines the CKEditor plugin settings (`cdn_flag`, `img`, `ratio`).

## Provides

- **Block plugin** `bootstrap_flag_icons_block` — `src/Plugin/Block/BootstrapFlagIconsBlock.php` (admin label "Bootstrap Language switcher"), with per-language-type derivatives from `src/Plugin/Derivative/BootstrapFlagIconsBlock.php`.
- **CKEditor 5 plugin** `bootstrap_flag_icons_plugin` (id `flagIcons.FlagIcons`) — `src/Plugin/CKEditor5Plugin/FlagIcons.php`, declared in `bootstrap_flag_icons.ckeditor5.yml`.
- **Theme hook + preprocess** `links__bootstrap_flag_icons_block` — `bootstrap_flag_icons.module`, template `templates/links--bootstrap-flag-icons-block.html.twig`.
- **hook_help** — `src/Plugin/Hook/BootstrapFlagIconsHook.php` (renders README on the module help page).
- **Libraries** — `bootstrap_flag_icons.libraries.yml`: `bootstrap_flag_icons` (block CSS), `flag-icons` (CDN), `admin.flag_icons`, `flag_icons.plugin` (CKEditor JS).

## Solution docs

- [Bootstrap language-switcher block](blocks/language-switcher.md) — placement, display-style option, theming.
- [CKEditor 5 flag-icon plugin](plugins/ckeditor-flag-icons.md) — enabling on a text format, settings, allowed elements.
