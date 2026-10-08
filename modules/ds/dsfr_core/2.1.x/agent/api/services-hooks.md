<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Core — services, Tools API, hooks & install

## Services (`dsfr_core.services.yml`)
All four are plain classes (no injected args; they use `\Drupal::service(...)` internally):
- `dsfr_core.tools` → `Drupal\dsfr_core\Tools`
- `dsfr_core.fieldStorage` → `Drupal\dsfr_core\FieldStorage`
- `dsfr_core.fieldManage` → `Drupal\dsfr_core\FieldManage`
- `dsfr_core.filterEditor` → `Drupal\dsfr_core\FilterEditor`

(`fieldStorage`/`fieldManage`/`filterEditor` are covered in
[../fields/field-tooling.md](../fields/field-tooling.md).)

## `Tools` helper API (`src/Tools.php`, service `dsfr_core.tools`)
Shared utility toolkit used across DSFR modules:
- Theme detection: `checkTheme()` (current default theme, theme list, `missing` bool for `dsfr`),
  `checkThemeActivated($theme = 'dsfr')`, `checkRegions()`.
- Module/env detection: `checkModules($module_name, $routes = [])` (moduleExists + builds route
  links), `checkDrupalVersion()` (major version string, e.g. for CKEditor 5 D9/D10 branching).
- Small helpers: `path($route, $params = [])` (`Url::fromRoute(...)->toString()`),
  `msg($get_msg, $type = 'success')` (messenger status/warning/error), `timeZone()`
  (`system.date` default timezone).
- Generic DB helpers: `checkTable`, `createTable`, `columnsTable`, `selectTable`, `insertTable`,
  `updateTable`, `deleteTable` (guarded by a `$permission` bool), `dropTable` (guarded). These are a
  low-level convenience layer over `Database::getConnection()`; no dsfr_core route or controller
  calls them, and dsfr_core itself never passes request input into them.

## Permission (`dsfr_core.permissions.yml`)
- `administer dsfr_core settings` — "Administer services for other DSFR modules." Gates the
  settings/theme/get-started/fields routes.

## Menu links (`dsfr_core.links.menu.yml`)
- `dsfr_core.settings` (Structure → DSFR), children `dsfr_core.dashboard`, `dsfr_core.theme`,
  `dsfr_core.icons` (weight 30), `dsfr_core.pictograms` (weight 25).

## Theme hooks — `dsfr_core_theme()` (`dsfr_core.module`)
- `_icons` (vars `language`, `slug`; `templates/-icons.html.twig`)
- `_pictograms` (vars `dsfr_path`, `language`, `slug`; `templates/-pictograms.html.twig`)
- `dsfr_settings` (var `dsfr`; `templates/dsfr-settings.html.twig`)
- `dsfr_get_started` (var `data`; `templates/dsfr-get-started.html.twig`)

## Libraries (`dsfr_core.libraries.yml`)
- `dsfr_color_selector` (CSS `dist/css/color_selector.min.css`).
- `preact_icons` / `preact_pictograms` (`dist/js/*_list.min.js` as `type: module` + CSS; depend on
  `dsfr_twig_components/code_css`). See [../browser/icons-pictograms.md](../browser/icons-pictograms.md).

## Install & alter hooks (`dsfr_core.module`)
- `hook_install()`:
  1. Iterates all content-entity bundles and sets `settings.alt_field_required = FALSE` on every
     `image`-type field (`field.field.*` config) — removes the mandatory ALT constraint for DSFR
     accessibility parity.
  2. If a `restricted_html_dsfr` format does not already exist, calls
     `dsfr_core.filterEditor`→`createFilterEditor('restricted_html_dsfr', 'Restricted HTML for some
     DSFR components')` (creates the format + CKEditor 5).
- `hook_form_alter()`: attaches the `dsfr_core/dsfr_color_selector` library to **every** form.
- No `hook_uninstall`/`hook_requirements`/`.install` schema; no config schema (no `config/` dir); no
  Drush commands; no plugin types.

## Notes
- No `composer.json` in this checkout → no external composer requirements; dependencies come only
  from `info.yml` (`dsfr_twig_components`, `form_options_attributes`, `style_selector`).
- French UI translations ship in `translations/dsfr_core-fr.po`.
