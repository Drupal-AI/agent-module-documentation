<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Darkmode (darkmode) — agent index

**Client-side light/dark theme toggle: a single block plugin that boots the Darkmode.js library in the browser and shows a floating toggle button.**

- **Version:** 1.0.x — core `^9.2 || ^10 || ^11`; license GPL-2.0-or-later.
- **Dependencies:** no Drupal module deps. Needs the third-party `darkmode-js` npm-asset installed at `web/libraries/darkmode-js` (loaded via `darkmode/darkmodejs`).
- **Provides:** one block plugin `darkmode_switcher` (`src/Plugin/Block/DarkmodeSwitcherBlock.php`). No routes, no permissions, no services, no entities, no Drush, no `config/install`.
- **Libraries** (`darkmode.libraries.yml`): `darkmodejs` (vendored lib), `initiator` (`js/init.js`, depends on jQuery/Drupal/core/once + `darkmodejs`), `darkmodecss` (`css/styles.css`).
- **Config schema:** `config/schema/darkmode.schema.yml` defines `block.settings.darkmode_switcher` (block-level settings only; `provides_config_schema: true`).
- **Install:** `darkmode.install` `hook_update_10001` migrates legacy `darkmode.config` values into existing `darkmode_switcher` block settings, then deletes the old config.
- **How it works:** the block's `build()` attaches `drupalSettings.darkmode` + the `initiator`/`darkmodecss` libraries; `js/init.js` runs `new Darkmode(options)` and `showWidget()`, honoring `themeMode` (`auto`/`light`/`dark`).

## Solution docs
- [Darkmode Switcher block & configuration](blocks/switcher.md)
