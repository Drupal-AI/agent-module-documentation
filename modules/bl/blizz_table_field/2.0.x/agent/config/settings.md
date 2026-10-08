<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site settings, config object & library setup

## Settings form

`SettingsForm` (`src/Form/SettingsForm.php`, `ConfigFormBase`, form id `settings_form`) at route
**`blizz_table_field.settings_form`** → path **`/admin/config/content/blizz_table_field/settings`**,
permission **`administer site configuration`** (`_admin_route: TRUE`). Menu link
`blizz_table_field.settings_form` under *Configuration → Content* (`system.admin_config_content`).

Editable config object: **`blizz_table_field.settings`**. Fields:

| Form field | Config key | Purpose |
|---|---|---|
| License key | `license_key` | Handsontable commercial license key; passed to JS as `drupalSettings.handsontable.license_key`. Empty = evaluation/non-commercial. |
| Path to `handsontable.full.min.js` | `required_library_files.handsontable.js` (sequence) | JS file path (default `libraries/handsontable/handsontable/dist/handsontable.full.min.js`). |
| Path to `handsontable.min.css` | `required_library_files.handsontable.css.component` (sequence) | CSS file path (default `libraries/handsontable/handsontable/dist/handsontable.min.css`). |
| Path to `papaparse.min.js` | `required_library_files.papaparse.js` (sequence) | PapaParse JS path (default `libraries/papaparse/papaparse.min.js`). |
| Formatting Options | `formatting_options` | Help HTML shown in the widget's "Formatting options" details (default seed in `config/install/`). |

`submitForm()` stores each library path as a **single-element array** (the schema types them as
sequences); `blizz_table_field_merger()` in the `.module` later re-keys those paths into the
`libraries.yml` definitions via `hook_library_info_alter`.

## Config schema (`config/schema/blizz_table_field.schema.yml`)

- `blizz_table_field.settings` (`config_object`): `formatting_options` (string), `license_key`
  (string), and `required_library_files` (mapping → `handsontable.js` sequence,
  `handsontable.css.component` sequence, `papaparse.js` sequence).
- `field.formatter.settings.table_formatter` and `field.widget.settings.table_widget` (documented in
  [../fields/table.md](../fields/table.md)).

Install defaults ship in `config/install/blizz_table_field.settings.yml` (a sample Markdown help
block in `formatting_options`, plus the three default library paths).

## Library wiring (`blizz_table_field.libraries.yml` + `.module`)

Defined libraries: `handsontable` (base CSS + drupal/drupalSettings), `papaparse`, `handsontable-json`
(→ `js/init.handsontable.json.js`), `handsontable-csv` (→ `init.handsontable.csv.js` + papaparse),
`frontend` (`css/frontend.css`). The Handsontable/PapaParse JS files themselves are empty in the YAML
and **filled in at runtime** from config by `hook_library_info_alter` → `blizz_table_field_merger()`.

`blizz_table_field_libraries_exists()` checks each configured path exists under `DRUPAL_ROOT`;
`hook_requirements()` raises `REQUIREMENT_ERROR` ("Not installed") at runtime when any is missing.

## Install checklist

1. Add the asset-packagist repository to `composer.json` (see the project page / README).
2. `composer require oomphinc/composer-installers-extender` and map `bower-asset`/`npm-asset`
   installer paths to `web/libraries/{$name}`.
3. `composer require drupal/blizz_table_field` — pulls `league/commonmark`,
   `bower-asset/handsontable ^12`, `bower-asset/papaparse ^5.3`.
4. Confirm the JS files landed under `web/libraries/…`; adjust paths in the settings form if not.
5. `drush en blizz_table_field -y`.

## Update hook

`blizz_table_field_update_9201()` re-seeds `license_key` (to `''`) and the three
`required_library_files` paths on existing sites.
