<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR for Drupal - Colors (dsfr4drupal_colors) — agent index

A Field API module that stores and displays colors from the official **DSFR** (French State
Design System) palette. Values are DSFR **CSS variable names** (e.g. `blue-france-main-525`),
not hex — so they follow light/dark mode. Package `DSFR for Drupal`. Depends only on core
**`field`**. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version **1.2.x** (installed
1.2.3). Configure at `dsfr4drupal_colors.settings`.

## What it provides (from source)

- **Field type** `dsfr4drupal_color_field_type` (`src/Plugin/Field/FieldType/ColorFieldType.php`):
  one `color` varchar(128) property; regex constraint restricting the value to a DSFR color-token
  shape; per-field settings for *allowed colors* and *contrast-ratio validation*.
- **Widget** `dsfr4drupal_color_field_widget_box` (`ColorFieldWidgetBox`, base `ColorFieldWidgetBase`)
  — visual color-box picker; settings *squares size* and *search input*.
- **Render element** `dsfr4drupal_color_box` (`src/Element/ColorBoxElement.php`, extends core
  `Textfield`) — reusable in custom forms.
- **Formatters** (`src/Plugin/Field/FieldFormatter/`): `..._text` (default), `..._swatch`,
  `..._css`, and abstract `ColorFieldFormatterBase`.
- **Service** `dsfr4drupal_colors.helper.colors` = `ColorsHelper` (interface `ColorsHelperInterface`)
  — parses the DSFR library CSS, lists/sorts/groups colors, builds `--name` / `var(--name)`,
  writes `public://dsfr4drupal-colors.css`.
- **Controller** `ColorsController::collection` — palette preview page.
- **Form** `SettingsForm` — chooses the light/dark form palette (config `dsfr4drupal_colors.settings:scheme`).
- **Hooks** (`src/Hook/Dsfr4drupalColorsHooks.php`): `help`, `token_info` + `tokens`
  (`dsfr4drupal_color_field` token type), `content_export_field_value_alter` (single_content_sync),
  `cron` (regenerates the CSS file). `.module` wraps them with `#[LegacyHook]`.
- **SDC component** `dsfr4drupal_colors:color-swatch` (`components/color-swatch/`).
- No permissions of its own, no Drush, no submodules. Provides config schema.

## Routes

- `dsfr4drupal_colors.collection` → `/admin/config/user-interface/dsfr4drupal-colors` — palette
  preview (`ColorsController::collection`); perm `administer site configuration`.
- `dsfr4drupal_colors.settings` → `.../settings` — `SettingsForm`; perm `administer site configuration`.

## Solution docs

- **Field type, widgets, render element, per-field settings** → [fields/field-type-widget.md](fields/field-type-widget.md)
- **The four formatters + swatch component** → [fields/formatters.md](fields/formatters.md)
- **Settings form, config, routes, collection page** → [config/settings.md](config/settings.md)
- **ColorsHelper service, tokens, cron, CSS file, install/requirements** → [api/helper.md](api/helper.md)

## Requirements

Needs the DSFR asset library on disk at `libraries/dsfr/dist/` (`LIBRARY_PATH` in
`ColorsHelperInterface`). `hook_requirements` (runtime) errors if `core/core.css` is missing.
`hook_install` generates the colors CSS file immediately.
