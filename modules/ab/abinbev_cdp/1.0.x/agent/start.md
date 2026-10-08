<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AbInBev CDP (abinbev_cdp) — agent index

A single **Webform submission handler** that maps a webform's fields to AB InBev **Customer Data
Platform** attributes and POSTs each submission to **Treasure Data** (`in.treasuredata.com`).
Package `AbInBev`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.32.

## What it actually is

- One plugin: `CDPSettingsHandler` (`@WebformHandler` id **`cdp_settings_handler`**, label *"CDP
  Settings Handler"*, category *"CDP Settings"*), in
  `src/Plugin/WebformHandler/CDPSettingsHandler.php`, extending `WebformHandlerBase`. Cardinality
  **unlimited**, results **processed**, submission **optional**, tokens enabled.
- One `hook_theme()` in `abinbev_cdp.module` (`webform_handler_cdp_submit_handler_summary`) with a
  matching template in `templates/`. No routes, **no permissions**, no config schema, no config
  install, no services, no install/update hooks, no submodules, no composer.json.
- **Runtime dependency on `webform`** (extends its handler base) but `abinbev_cdp.info.yml`
  declares **no `dependencies:`** — enable `webform` yourself.

## Provides

- Plugin instance of Webform's `WebformHandler` type (it does not define a new plugin type).
- Handler config groups: `user_settings` (field mappings), `purposes` (consent flags),
  `campaign_details` (campaign metadata + country + dev/prod + CDP keys).

## Docs

- **The handler: install, every setting, the submit/validate flow, the CDP payload and endpoint** →
  [plugins/cdp-settings-handler.md](plugins/cdp-settings-handler.md)
