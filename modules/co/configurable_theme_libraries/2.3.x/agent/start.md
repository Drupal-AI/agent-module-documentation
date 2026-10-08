<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configurable Theme Libraries — agent index

info.yml name: **Configurable Theme Libraries** (`configurable_theme_libraries`), version **2.3.1**,
package Theming, `core_version_requirement: ^8 || ^9 || ^10 || ^11`. No module dependencies; no
routes, no permissions, no Drush, no config schema of its own.

A **theme-developer** feature. A theme declares selectable library sets under a `configurable-libraries`
key in its `THEME.info.yml`; the module exposes them as checkboxes on the **core theme settings form**
so a site builder can toggle which of those predefined sets load. Values are stored in the theme's own
settings and merged into the active theme at build time.

## What each file does

- `configurable_theme_libraries.module` — `hook_form_system_theme_settings_alter()`: when the theme
  settings form is built for a specific theme (`$build_info['args'][0]`), merges in the checkboxes from
  `configurable_theme_libraries.manager::getConfigurableLibrariesForm($theme)`.
- `src/ConfigurableThemeLibrariesManager.php` (service `configurable_theme_libraries.manager`, arg
  `@theme_handler`) — reads `configurable-libraries` from the theme's parsed info; builds a
  `#type => checkboxes` element (`configurable_libraries[libraries]`, `#tree`) whose `#options` are
  `id => name` and per-option `#description`. `#default_value` and the static `isEnabled($theme, $id)`
  read `theme_get_setting('configurable_libraries.libraries', $theme)` (`!empty($settings[$id])`).
- `src/Extension/ConfigurableThemeLibrariesInfoParser.php` — **decorates `info_parser`**. After the
  core parse, validates each `configurable-libraries` entry: requires a `name` key and at least one of
  `libraries` / `libraries-extend` / `libraries-override`, else throws `InfoParserException`.
- `src/Theme/ThemeInitialization.php` — **decorates `theme.initialization`**. In `getActiveTheme()`,
  for each enabled configurable library it merges that entry's `libraries-override`, `libraries-extend`
  and `libraries` into a rebuilt `ActiveTheme`. If none enabled, returns the unmodified active theme.
- `configurable_theme_libraries.services.yml` — registers the manager and the two decorators.

## Key facts

- The only web-facing surface is the core theme settings form at
  `/admin/appearance/settings/YOUR_THEME` (core route `system.theme_settings_theme`, gated by core
  permission **administer themes**). The module adds no route or permission of its own.
- Library names/paths are defined only in the theme's `THEME.info.yml` on disk. The settings UI lets an
  admin **toggle** predefined sets on/off — it does not accept arbitrary library names or asset URLs.
- `configurable-libraries` entry shape: `name` (required, human label), `description` (optional), and
  any of `libraries`, `libraries-extend`, `libraries-override` (same syntax as a theme's normal keys).
- Storage: a `configurable_libraries.libraries` map (`id => 0|1`) inside the theme's settings; enabled
  means the checkbox value is truthy.

Human-oriented guide: `../human-docs/`. Task-oriented usage: `../usage.md`.
