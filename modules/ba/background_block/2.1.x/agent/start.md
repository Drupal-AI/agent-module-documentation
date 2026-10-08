<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Background Block (background_block) — agent index

Adds an optional **per-block background color and opacity** to core Block-layout blocks. No settings page,
no plugins, no services — it just alters the block form and preprocesses block output. Version **2.1.2**,
core `^8.9 || ^9 || ^10 || ^11`.

## Depends on
- `drupal:block` (core Block module) — the only dependency.

## What it provides
- Permission: `administer background block` (`background_block.permissions.yml`) — gates the color/opacity
  fields on the block form.
- `hook_form_block_form_alter()` — adds a "Color settings" fieldset (`#type` `color` + opacity `number`)
  under `third_party_settings[background_block][colors_settings]`.
- `hook_ENTITY_TYPE_presave()` (`background_block_block_presave`) — housekeeping that unsets an empty
  `background` third-party setting.
- `hook_preprocess_block()` — writes the stored values onto the block's `style` attribute.
- `hook_help()` for `help.page.background_block`.
- No routes, no config/install, no config/schema, no Drush, no libraries, no submodules.

## Storage
Values live as **block config-entity third-party settings** under the `background_block` provider
(`colors_settings.background`, `colors_settings.opacity`). They export/import with the block config.

## Solution docs
- [config/settings.md](config/settings.md) — the form fields, third-party-setting keys, preprocess
  behavior, permission, and the known functional quirks.
