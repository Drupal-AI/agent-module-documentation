<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Country Alter UI (country_alter_ui) — agent index

An admin settings form that rewrites Drupal's **built-in country list** — override/add
`code|name` entries, filter countries out by ISO code, and optionally sort alphabetically —
applied at runtime through a **`hook_countries_alter()`** implementation. Core-only, no package,
`core_version_requirement: ^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.1.x.

- **The settings form, config object/schema, the alter hook, route & permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No dependencies** beyond Drupal core. No content entities, no field types/widgets/formatters,
  **no permissions of its own**, no Drush commands, no plugin types, no external services/APIs.
- One **config form**: `CountryAlterSettingsForm` (`src/Form/CountryAlterSettingsForm.php`,
  `getFormId() = country_alter_ui_settings_form`), a `ConfigFormBase` editing config object
  **`country_alter_ui.settings`**. Injects core's **`country_manager`**
  (`CountryManagerInterface`) to populate the filter select.
- One **hook** implementation via the class/attribute hook system:
  `CountryAlterUiHooks::countriesAlter()` (`src/Hook/CountryAlterUiHooks.php`, `#[Hook('countries_alter')]`),
  registered as an autowired service in `country_alter_ui.services.yml`. The legacy procedural
  bridge `country_alter_ui_countries_alter()` (`.module`, `#[LegacyHook]`) delegates to it.

## Route & menu

- **Route** `country_alter_ui.settings_form` → path **`/admin/config/regional/countries`**,
  `_form` = `CountryAlterSettingsForm`, requirement **`_permission: 'administer site configuration'`**
  (core's standard admin permission — the module defines none). Set as `configure:` in the info file.
- **Menu link** `country_alter_ui.settingsform` (`*.links.menu.yml`) under
  `system.admin_config_regional` (Configuration → Regional and language), weight 201.

## Config object

`country_alter_ui.settings` (install defaults `countries: {}`, `filter_countries: {}`,
`sort_alphabetically: false`; schema `config/schema/country_alter_ui.schema.yml`):
`countries` (sequence of `code|name` strings), `filter_countries` (sequence of ISO codes),
`sort_alphabetically` (boolean). Full key/behavior detail in
[config/settings.md](config/settings.md).
