<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EcoIndex settings & the minimum-score gate

## Route, form, permission
- Route `ecoindex.settings` → `/admin/structure/ecoindex/settings`, `_form:
  \Drupal\ecoindex\Form\EcoIndexSettingsForm`, requirement `_permission: 'administer ecoindex
  settings'`. This is the `configure` route (declared in `ecoindex.info.yml`).
- Menu link `ecoindex.settings` (`ecoindex.links.menu.yml`) under `system.admin_config_services`
  (Configuration → Web services / Development area).
- Permissions (`ecoindex.permissions.yml`): `administer ecoindex settings`, `update ecoindex field`.

## Form (`EcoIndexSettingsForm`, extends `ConfigFormBase`)
- `getFormId()` = `ecoindex_admin_settings`; edits config `ecoindex.settings`.
- Fields:
  - `minimum_score` — `#type number`, min 0 / max 100, default 0. "Minimum score to alert
    contributor."
  - `required_to_publish` — `#type checkbox`, default FALSE. "Is required to publish content?"
- `submitForm()` saves both keys to `ecoindex.settings`.

## Config object `ecoindex.settings`
- `config/install/ecoindex.settings.yml`: `minimum_score: 0`, `required_to_publish: false`.
- Schema `config/schema/ecoindex.schema.yml`:
  - `ecoindex.settings` (config_object): `minimum_score` (integer), `required_to_publish` (boolean).
  - `diff.plugin.settings.ecoindex_field_diff_builder` (extends `diff.plugin.settings_base`):
    `compare_score`, `compare_grade`, `compare_element_count`, `compare_request_count`,
    `compare_total_size_kb` — settings for the Diff field-diff builder plugin that compares
    EcoIndex values across revisions (requires the `drupal/diff` module).

## How the settings are consumed
- `minimum_score` is pushed to `drupalSettings.ecoindex.minimum_score` on the preview page
  (`ecoindex_page_attachments_alter()`); `js/ecoindex.js` shows a warning message when the measured
  score is below it.
- `required_to_publish` + `minimum_score` drive the `EcoIndexField` validation constraint — see
  [../fields/field.md](../fields/field.md). When enabled, publishing an entity whose EcoIndex
  `score` is above 0 but below `minimum_score` raises a validation violation and blocks the save.
