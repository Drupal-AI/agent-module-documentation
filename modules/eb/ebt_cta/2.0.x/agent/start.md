<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Call to Action (ebt_cta) — agent index

Installs a `block_content` bundle **`ebt_cta`** ("EBT Call to Action") — title, body, image
column and one or two styled buttons — built on the EBT (`ebt_core` / `ebt_basic_button`)
framework. No routes, no permissions, no services beyond CSS generation. Version 2.0.x,
core `^10.1 || ^11 || ^12`, package "Extra Block Types".

## Dependencies

- `drupal/ebt_basic_button` `^2.0` (button widget + `generate_custom_css` service)
- `drupal/ebt_core` `^2.0` (provides the `ebt_settings` field type + `ebt_core.settings`)
- `drupal/paragraphs` `^1.0`
- core `link`, `media` (info.yml deps: `link`, `media`, `ebt_basic_button`, `paragraphs`)

## What it provides

- **Block content type** `ebt_cta` (`config/install/block_content.type.ebt_cta.yml`) with fields:
  `field_ebt_cta_title` (text_long), `body`, `field_ebt_cta_column_image` (Media/entity_reference
  to image), `field_ebt_cta_link` (required link), `field_ebt_cta_second_link` (optional link),
  `field_ebt_settings` (`ebt_settings`).
- **Field widget plugin** `ebt_settings_cta` — `src/Plugin/Field/FieldWidget/EbtSettingsCtaWidget.php`
  (extends `EbtSettingsBasicButtonWidget`); adds CTA layout/style controls.
- **Service** `ebt_cta.generate_cta_css` — `src/Services/GenerateCtaCSS.php`; turns settings into
  responsive/layout `<style>`.
- **Hook class** `EbtCtaHooks` (`src/Hook/EbtCtaHooks.php`): `help`, `preprocess_block` (attaches
  `button_styles` + `cta_styles` inline styles).
- **Templates** `templates/block--block-content--ebt-cta.html.twig`,
  `templates/block--inline-block--ebt-cta.html.twig`; **library** `ebt_cta/ebt_cta` (`css/ebt_cta.css`).
- **Install logic** `ebt_cta.install`: `hook_requirements` (needs a Media "image" type),
  `update_9201` (makes link title optional), `hook_uninstall` (keeps the block type).

No config-schema files, no Drush commands, no submodules.

## Solution docs

- [Block type, fields & display](agent/blocks/cta-block.md) — the bundle, its six fields, form/view
  displays, and how instances are created and placed.
- [CTA settings widget & CSS generation](agent/config/settings.md) — the `ebt_settings_cta` widget
  options, `GenerateCtaCSS`, `preprocess_block`, and template rendering.
