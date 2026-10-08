<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal - Picker - Link (dsfr4drupal_picker_link) — agent index

Submodule of DSFR for Drupal - Picker. Adds an icon picker to core Link fields via a custom field widget and stores the chosen DSFR icon machine name inside the link item's `options.icon`.

- Machine name: `dsfr4drupal_picker_link`
- Dependencies: `dsfr4drupal_picker` (parent), `link` (core).
- Core: `^10.3 || ^11 || ^12`. License: GPL-2.0-or-later. No permissions, routes, or services.

## What it provides
- Field widget `dsfr4drupal_picker_link_icon` ("Link with DSFR icon") — `Drupal\dsfr4drupal_picker_link\Plugin\Field\FieldWidget\LinkIconWidget`, for `link` field types.
- `LinkiconWidgetTrait` — helper trait that prefixes the parent `PickerWidgetTrait` settings with `icon_` and adds `icon_allowed_groups` / `icon_required` defaults.
- `hook_config_schema_info_alter()` in `dsfr4drupal_picker_link.module` — registers the `icon` string key on `field.value.link` `options`.
- Config schema `config/schema/dsfr4drupal_picker_link.schema.yml` — widget settings (`field.widget.settings.dsfr4drupal_picker_link_icon`) and formatter settings (`field.formatter.settings.dsfr4drupal_picker_link_icon`).

## Solution docs
- [Link-with-icon widget](fields/widget.md) — the widget, its settings, and how the icon is stored.
