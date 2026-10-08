<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Buy Me a Coffee (bmc) — agent index

Integrates the hosted **Buy Me a Coffee** donation platform into Drupal by rendering the platform's
official CDN scripts. No custom payment code, no server-side API calls — everything runs client-side
and links to the configured account. Depends only on core **`block`**. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.10 (version dir `1.0.x`). Package: none declared.

## What it provides (all grounded in source)

- **Block plugin** `BmcButtonBlock` (id **`by_mee_coffee_block`**, label "Buy Me a Coffee"),
  `src/Plugin/Block/BmcButtonBlock.php`. `build()` emits one `#type => html_tag` `<script>` with
  `src = https://cdnjs.buymeacoffee.com/1.0.0/button.prod.min.js` and `data-*` attributes
  (`data-slug` = username, plus text/font/colors) from config `bmc.settings:bmc_settings`.
- **Site-wide widget** via `hook_page_attachments_alter()` in `bmc.module`. When
  `bmc_settings.widget_visible` is on **and** the current path does not start with `/admin`, it
  attaches an `html_head` `<script>` (`src = …/1.0.0/widget.prod.min.js`) carrying `data-id`,
  `data-description`, `data-message`, `data-color`, `data-position`, `data-x_margin`,
  `data-y_margin` from config.
- **Config form** `BmcConfigurationForm` (`ConfigFormBase`, form id `bmc_settings_form`) at
  **`/admin/config/bmc-configuration`** (route `bmc.setting_form`, perm **`administer bmc`**).
  Editable config: **`bmc.settings`**. Details → [config/settings.md](config/settings.md).
- **Custom form element** `bmc_color_picker` (`src/Element/ColorPicker.php`, extends core `Radios`)
  — preset swatches + optional custom-hex input, validated against `/^#[0-9A-F]{6}$/`.
  Details → [config/settings.md](config/settings.md).
- **Help controller** `BmcHelpController::helpContent()` at **`/admin/help/bmc`** (route `bmc.help`,
  perm `administer site configuration`) — static markup.
- **Permission** `administer bmc` (`bmc.permissions.yml`, `restrict access: true`).
- **Libraries** (`bmc.libraries.yml`): `bmc/color_picker` (CSS), `bmc/color_picker_custom`
  (JS `js/bmc.color-picker-custom.js`, depends `core/once`).

## Not present

No `.install`, no `config/schema` or `config/install` (config has **no schema** — keys default in
PHP), no services file, no Drush, no entities, no submodules, no hooks besides
`hook_page_attachments_alter()`. The module performs **no outbound HTTP** from PHP.

## Docs

- **Settings form, the `bmc.settings` config keys, defaults, the color-picker element, routes &
  permissions** → [config/settings.md](config/settings.md)
