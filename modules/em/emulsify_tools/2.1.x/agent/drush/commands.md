<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (Drush 13+)

Two command classes (`drush.services.yml` autowires `SubThemeCommands`; `FaviconCommands` is autowired).
All are attribute-style commands and require Drush 13+ (the module `conflict`s with `drush/drush <13`).

## Child theme generation — `SubThemeCommands`

- **`emulsify_tools:bake <name>`** (alias **`emulsify`**) — generate an Emulsify child theme under
  `themes/custom/<machineName>` from the Emulsify starter, customizing names. Example:
  `drush emulsify_tools:bake MyThemeName` or `drush emulsify MyThemeName`. The generated theme uses
  `emulsify` as its runtime parent. Intended for Emulsify Drupal 6.x child themes.
- **`emulsify_tools:repair-favicon-config [theme]`** — scan Emulsify-based child themes and backfill
  missing favicon entries in `config/install/<theme>.settings.yml` and `config/schema/<theme>.schema.yml`
  (existing values preserved). Omit the arg to process all; pass a machine name to target one.

## Favicon deployment — `FaviconCommands`

Owned by Emulsify Tools; generation/status/reset delegate to the Emulsify Drupal 7.x favicon manager. The
target must be `emulsify` or an Emulsify child theme; omit the name to use the default frontend theme.

- **`emulsify_tools:favicon-generate [theme]`** — generate/refresh the favicon package from the saved
  Emulsify theme settings. Use in deploy hooks / after config import.
- **`emulsify_tools:favicon-status [theme]`** — report whether generation is enabled, whether the package
  exists, whether GD/Imagick are available, and whether a portable SVG source exists.
- **`emulsify_tools:favicon-reset [theme]`** — remove generated package metadata/assets and restore default
  favicon behavior.

Typical deploy flow: configure & save favicon in the Emulsify theme settings form → export/import config →
`drush emulsify_tools:favicon-generate my_theme` → `drush emulsify_tools:favicon-status my_theme`.

Note: the favicon commands expect the Emulsify Drupal 7.x companion theme APIs; on a site without an
Emulsify theme they have nothing to operate on. The Twig helpers and namespaces work regardless.
