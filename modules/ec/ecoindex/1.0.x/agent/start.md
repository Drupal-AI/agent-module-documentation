<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EcoIndex (ecoindex) — agent index

Unofficial Drupal integration of the Green IT association's **EcoIndex** algorithm. Adds an
`ecoindex` **field type** (score, grade, element_count, request_count, total_size_kb) plus a
per-node **preview route** that computes the score **in the browser** (GreenIT-Analysis
`ecoIndex.js`) and copies it into the node edit form to be saved. Package `EcoIndex`. Core
`^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1-beta4 (version-dir 1.0.x).

- **No hard module dependencies.** composer.json requires `drupal/diff` (`^1.7`); a diff field
  builder plugin (`ecoindex_field_diff_builder`) is provided for comparing scores across revisions.
- **Measurement is entirely client-side** — there is no server-side HTTP call to any EcoIndex API.
  Values flow: preview page → `js/ecoindex.js` (bundled cnumr library) → `localStorage` →
  `js/edit.js` fills the edit-form fields → normal node save persists them.

## What it provides (from source)

- **Field type** `ecoindex` — `src/Plugin/Field/FieldType/EcoIndexItem.php`. Columns: `score`
  (tiny int), `grade` (varchar 1), `element_count`/`request_count` (int), `total_size_kb` (float).
  Default widget `ecoindex_widget`, default formatter `ecoindex_score_formatter`, constraint
  `EcoIndexField`.
- **Widget** `ecoindex_widget` — `src/Plugin/Field/FieldWidget/EcoIndexWidget.php`. Details element
  with number inputs + grade select; adds a "Refresh EcoIndex score" link to the preview route.
- **Formatters** `ecoindex_score_formatter` and `ecoindex_grade_formatter` (both `#plain_text`) —
  `src/Plugin/Field/FieldFormatter/`.
- **Validation constraint** `EcoIndexField` — blocks publishing below the minimum score when
  configured. `src/Plugin/Validation/Constraint/`.
- **Settings form** `EcoIndexSettingsForm` at `/admin/structure/ecoindex/settings`
  (route `ecoindex.settings`), config object `ecoindex.settings`.
- **Preview route** `ecoindex.preview` = `/node/{node}/ecoindex`, and an event subscriber that
  renders it as the anonymous user.
- **Services**: `ecoindex.helper` (`EcoIndexHelper`), `ecoindex.preview_user_switch_subscriber`
  (`PreviewUserSwitchSubscriber`).
- **Permissions**: `administer ecoindex settings`, `update ecoindex field`. No Drush commands.

## Solution docs

- **Settings form + config object + minimum-score gate** → [config/settings.md](config/settings.md)
- **Field type, widget, formatters, validation constraint, install update** →
  [fields/field.md](fields/field.md)
- **Preview route, anonymous user switch, JS measurement flow, libraries, hooks** →
  [workflow/preview.md](workflow/preview.md)
