<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DSFR Core — field & text-format tooling

The programmatic toolkit sibling DSFR modules (dsfr_block, dsfr_paragraph, …) use to install their
DSFR-specific fields, form/view displays and rich-text format. These are **services**, called from
other modules and the install hook — not wired to routes with request input (the only HTTP surface
is the read-only report at `/admin/dsfr/fields/{slug}`; see
[../config/admin-pages.md](../config/admin-pages.md)).

## `FieldStorage` (service `dsfr_core.fieldStorage`, `src/FieldStorage.php`)
- `fieldData(): array` — the central catalogue of ~60 DSFR field definitions, keyed by field name,
  each with `type`, optional `module`, `display`, `view`, `settings`, `required`, `cardinality`.
  Groups: a `block` (block_field), `body`/`ckeditor5`/`message`/`text` (text/string), a `color`
  (`style_selector_css_class` using `colorsSimple()`), `media_image` (entity_reference to media);
  string fields (author/label/legend/placeholder/title/tooltip/id); boolean checkboxes
  (compact/disabled/hidden/show_color/show_icon/arrow_left/close/large/small/plus); `link`/`details`
  (link); `list_string` fields (alert/arrow_icon/badge_type/button_type/code_type/font_size/
  icon_position/margin_*/size/tag_type/title_type/title_style) with per-key allowed values; and
  `entity_reference_revisions` paragraph fields (accordion/badge/button/card/tab/tag/tile/toggle and
  their plural, cardinality -1). Result is `ksort`ed.
- `margin(): array` — DSFR spacing classes (`0-5v`…`32v` → px labels).
- `colors(): array` / `colorsSimple(): array` — the 17 standard DSFR colour options (id → label
  [+ hex]); `colorsSimple` drops the hex.
- `associativeArray(array): array` — turns `['title', …]` into `['title' => ['label' => 'Title']]`
  (ucfirst + `_`→space).

## `FieldManage` (service `dsfr_core.fieldManage`, `src/FieldManage.php`)
- `checkFieldsStorage(string $entity_type): string` — returns an HTML `<ul>` reporting, for every
  field in `FieldStorage::fieldData()`, whether `FieldStorageConfig::loadByName($entity_type,
  $field_name)` exists ("installed" / "To be installed"). Used by the fields report route.
- `installFieldsStorage(string $entity_type)` — for each catalogue field with no existing storage,
  calls `createFieldsStorage()`.
- `createFieldsStorage($field_name, array $conf, $entity_type = 'block_content'): FieldStorageConfig`
  — `extract($conf)` then `FieldStorageConfig::create([...])->save()` (langcode `en`, translatable,
  `format => 'restricted_html_dsfr'`).
- `createFields(array $conf, FieldStorageConfig $field_storage, string $bundle): FieldConfig` —
  `extract($conf)` then `FieldConfig::create([...])->save()`.
- `displayFields($entity_type, $entity_id, $field_name, ?$form_display_type)` — sets the form-display
  widget via `entity_display.repository`→`getFormDisplay(...)->setComponent(...)`.
- `viewFields($entity_type, $entity_id, $field_name, ?$view_display_type, $settings = [], $label_show
  = 'hidden')` — sets the view-display formatter via `getViewDisplay(...)->setComponent(...)`.

## `FilterEditor` (service `dsfr_core.filterEditor`, `src/FilterEditor.php`)
- `createFilterEditor($format_name, $format_label, $allowed_html = '<br> <p> <span> <mark> <strong>
  <em> <u> <code> <s> <sub> <sup> <a href> <ul> <ol> <li>', $roles = ['authenticated',
  'content_editor'], $filters = [], $toolbar_items = [])` — creates a `FilterFormat`
  (filter_html + filter_url + filter_htmlcorrector by default) **and** a matching `ckeditor5`
  `Editor`. Toolbar defaults to undo/redo/link/bold/italic/underline/strikethrough/super-/subscript/
  bulleted+numbered list; branches D9 vs D10+ config via `Tools::checkDrupalVersion()` and uses
  `Heading::DEFAULT_CONFIGURATION`. Invoked from `hook_install()` to create `restricted_html_dsfr`.

## `TestForm` (`src/Form/TestForm.php`, route `dsfr_core.test_form` → `/dsfr/test/form`)
- A developer/demo form (id `test_form`) with sample DSFR-styled elements: textfield, search,
  textarea, checkboxes, select, radios, submit. `submitForm()` only adds a
  `t('Form submitted successfully.')` messenger message — it performs **no** persistence, entity
  writes, or side effects. Gated by `administer dsfr_block settings`. Exists to preview DSFR form
  theming.
