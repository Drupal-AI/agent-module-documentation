<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Paragraphs (bulk_paragraphs) — agent index

Adds a **"Bulk generate" modal** to Paragraphs widgets that mass-creates paragraph entities
(1-100 at a time) with per-field default values and increment/template patterns. Package
**Paragraphs**. Version **1.4.0**. Core `^11.1 || ^12`. License GPL-2.0-or-later.
Depends on contrib **`paragraphs`** and core **`datetime`**.

- **Generate form, routes, permission, tempstore/AJAX flow, hooks, cron** →
  [api/generation.md](api/generation.md)
- **Admin settings form, config object + schema, per-widget toggle** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No new entity types, no plugin types, no services** beyond a hooks class and a logger channel.
  It hooks into core/Paragraphs form building.
- One dedicated **permission**: `use bulk paragraphs` (`bulk_paragraphs.permissions.yml`).
- Two **routes** (`bulk_paragraphs.routing.yml`):
  - `bulk_paragraphs.generate_form` — `/bulk-paragraphs/generate/{entity_type}/{bundle}/{field_name}`,
    form `\Drupal\bulk_paragraphs\Form\BulkGenerateForm`, `_permission: 'use bulk paragraphs'`.
  - `bulk_paragraphs.settings` — `/admin/config/content/bulk-paragraphs`, form
    `BulkParagraphsSettingsForm`, `_permission: 'administer site configuration'`.
- **Hooks** in `src/Hook/BulkParagraphsHooks.php` (attribute `#[Hook]`, autowired service):
  `entity_prepare_form`, `field_widget_complete_form_alter`,
  `field_widget_third_party_settings_form`, `field_widget_settings_summary_alter`,
  `entity_insert`, `entity_update`, `cron`.
- **Config**: object `bulk_paragraphs.settings` (schema in `config/schema/`, install defaults in
  `config/install/`). Third-party setting `bulk_paragraphs.enabled` (default TRUE) on each
  ParagraphsWidget.
- Front-end: library `bulk_paragraphs/bulk_paragraphs` (`js/bulk-paragraphs.js`,
  `css/bulk-paragraphs.css`) plus `core/drupal.dialog.ajax`.

## Mechanism (from source)

- The widget alter (`fieldWidgetCompleteFormAlter`) adds one modal-dialog link per paragraph type
  into the Paragraphs widget's `add_more` area, plus a hidden AJAX "Refresh" submit button. Links
  point at the generate route with `paragraph_type`, `field_parents`, `wrapper_id` query args.
- `BulkGenerateForm` builds per-field-type default inputs (`buildFieldDefaultElement()` dispatch
  table), generates `Paragraph::create()` entities in `generateParagraphs()`, and stores their
  `target_id`/`target_revision_id` in the **private tempstore** collection `bulk_paragraphs` under
  key `entity_type:bundle:field_name[:field_parents]`.
- The hidden Refresh button's static `submitRefreshWidget()` pulls those ids from tempstore into
  `ParagraphsWidget` widget state; `entity_prepare_form` is the reload/no-JS fallback that reads
  the same tempstore key on plain page load. `entity_insert`/`entity_update` delete consumed
  tempstore keys after a successful host-entity save. `cron` deletes orphaned (no `parent_type`)
  generated paragraphs older than 24h.

## Value calculation

- `calculateFieldValue()` routes by field element shape: `template` (with `{n}`, `{n0}`,
  `{date:FORMAT}` via `processTemplate()`), `summary_template` (text_with_summary), `uri`/`title`
  (link), `value` (boolean), `list_value` (list), `fid` (image/file), else numeric/date increment
  (`calculateIncrementValue()` → `calculateDateValue()` / `calculateNumericValue()`).
- Increment options for date/numeric come from `bulk_paragraphs.settings` via
  `loadIncrementSettings()`, intersected against a fixed allow-list.

## Notes

- `count` is validated to 1-100 (form `#max` and `validateForm()`).
- URL params are validated in `validateParameters()`: machine-name regex, entity-type existence,
  numeric-or-machine-name field parents, HTML-id wrapper — invalid input throws
  `BadRequestHttpException`.
- Generated paragraphs are unattached until the host form is saved; the modal itself never edits
  the host entity.
