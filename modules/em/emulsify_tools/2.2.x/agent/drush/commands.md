<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands (Drush 13+)

Three command classes (`SubThemeCommands`, `FaviconCommands`, `RepairFaviconConfigCommands`), all autowired
attribute-style commands. Require Drush 13+ (the module `conflict`s with `drush/drush <13`).

## Child theme generation — `SubThemeCommands`

- **`emulsify_tools:bake <name>`** (aliases **`emulsify`**, **`emulsify_tools:generate-theme`**) — generate an
  Emulsify child theme under `themes/custom/<machineName>` from the Emulsify "whisk" starter.
  - `<name>` is a machine name **or** a human label; it is transliterated and validated into a Drupal
    machine name (lowercase, `[a-z0-9_]`, starts with a letter, not `emulsify`, not an existing theme, within
    the extension-name length limit). Invalid input fails with an actionable error.
  - `--name="My Theme"` sets the human-readable display name (defaults to the positional value);
    `--description="…"` sets the theme description.
  - Example: `drush emulsify_tools:bake my_theme --name="My Theme" --description="Project theme"` or
    `drush emulsify "My Theme"`.
  - Generation routes through `ThemeGeneratorInterface` (`EmulsifyThemeGenerator`): it uses **Drupal core's
    StarterKit** for a modern Emulsify 7.x "whisk" source (detected via `whisk.starterkit.yml`) and falls
    back to a **legacy generator** for the Emulsify 6.x layout (`whisk.info.emulsify.yml`). Requires the
    `emulsify` base theme (7.x) installed — otherwise it errors telling you to install a compatible Emulsify
    Drupal 7.x release.

Note: `SubThemeGenerator`, `LegacyThemeGenerator`, and `StarterRecipeArchiveExtractor` services are
**deprecated in 2.2.0, removed in 3.0.0**; use `ThemeGeneratorInterface` for programmatic generation.

## Favicon config repair — `RepairFaviconConfigCommands`

- **`emulsify_tools:repair-favicon-config [theme]`** — scan Emulsify-based child themes and backfill missing
  favicon entries in `config/install/<theme>.settings.yml` and `config/schema/<theme>.schema.yml` (existing
  values preserved). Omit the arg to process all; pass a machine name to target one. Reports per-theme
  install/schema results and an inspected/updated/unchanged/errors summary.

## Favicon deployment — `FaviconCommands`

Owned by Emulsify Tools; generation/status/reset delegate to the Emulsify Drupal 7.x favicon manager. The
target must be `emulsify` or an Emulsify child theme; omit the name to use the default frontend theme. Each
command accepts `--all` to act on every installed Emulsify-based theme.

- **`emulsify_tools:favicon-generate [theme] [--all]`** — generate/refresh the favicon package from the saved
  Emulsify theme settings. Use in deploy hooks / after config import. Reports the package path and hash.
- **`emulsify_tools:favicon-status [theme] [--all] [--format=…]`** — report whether generation is enabled,
  the package state, whether the package exists, whether GD/Imagick are available, and whether a portable SVG
  source exists (plus hash/path/generated-at). `--format` accepts Drush formats (`table`, `json`, `yaml`);
  default is human-readable text.
- **`emulsify_tools:favicon-reset [theme] [--all]`** — remove generated package metadata/assets and restore
  default favicon behavior.

Typical deploy flow: configure & save favicon in the Emulsify theme settings form → export/import config →
`drush emulsify_tools:favicon-generate my_theme` → `drush emulsify_tools:favicon-status my_theme`.

Note: the favicon commands expect the Emulsify Drupal 7.x companion theme APIs; on a site without an
Emulsify theme they have nothing to operate on. The Twig helpers and namespaces work regardless.
