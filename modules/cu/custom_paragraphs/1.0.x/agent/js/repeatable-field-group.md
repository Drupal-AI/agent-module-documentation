<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end: RepeatableFieldGroup (custom_paragraphs)

Source: `js/components/repeatable-field-group.js` (class `RepeatableFieldGroup`, exposed as
`window.RepeatableFieldGroup`). CSS: `css/custom-paragraphs.css`. Library:
`custom_paragraphs/custom_paragraphs`.

## Wire it into a form

1. Attach the library: `$form['#attached']['library'][] = 'custom_paragraphs/custom_paragraphs';`
2. Add a **hidden** element to hold the JSON value, e.g. `#type => 'hidden'` with
   `#attributes => ['id' => 'items-data']`.
3. Add a **container** to render into, e.g. `#type => 'container'` with class `rfg-wrapper` and a
   `data-rfg-instance` attribute (its value namespaces generated field ids).
4. In your own JS: `new RepeatableFieldGroup(wrapperEl, config);` There is **no automatic
   `Drupal.behaviors` attach** — you instantiate it yourself.

## Config keys (constructor `config`, see `constructor()`)

- `fields` (array) — field definitions (see below). `groupLabel` (default `"Item"`) titles each row.
- `minItems` (1), `maxItems` (Infinity), `initialItems` (1) — item-count bounds; add/remove buttons
  auto-enable/disable at the bounds (`toggleAddButton`, `toggleRemoveButtons`).
- `addButtonText` / `removeButtonText`, `addButtonId` / `removeButtonId`,
  `addButtonClass` / `removeButtonClass` (arrays) — button markup.
- `hiddenInputSelector` (**required**; the class aborts `init()` if the hidden input is not found),
  `storeAsJson` (default true) — where/whether to write the serialized JSON.
- `validationPrefix` (`"field"`), `validateBeforeAdd` (true) — validate all rows before adding one.
- `fieldGroupDefaultValue` (array of row objects) — pre-fills rows when editing existing data.
- CSS-class knobs: `itemClass`, `titleClass`, `fieldsClass`, `actionsClass`, `fieldWrapperClass`,
  `itemsContainerClass`.

## Field definition (`normalizeField()`)

Each entry is a string (shorthand for `type`) or object with: `type` (`text` | `textarea` |
`select` | `checkbox` | `file`; default `text`), `name` (default `field_<i>`), `label`,
`placeholder`, `required` + `requiredMessage`, `options` (for select; string or `{value,label}`),
`defaultValue`, `class`/`id`/`attributes`, `prefix`/`suffix` (HTML fragments), wrapper id/class
knobs. File fields also read `multiple`, `accept` (extension/MIME list), and `upload_location`
(the stream URI the upload endpoint writes to). Textareas read `editor` (set to `"ckeditor5"`) and
`editorFormat` (a text-format id) to enable rich text.

## Behavior

- `addItem()` / `removeItem()` build/remove rows; titles renumber via `renumberTitles()`.
- Non-file fields validate on `input`/`change` (`validateSingleField`); file fields upload on
  `change` (`handleFileFieldChange` → `uploadFilesToDrupal`) and render a preview list.
- CKEditor 5 attach/detach on add/remove via `Drupal.editors.ckeditor5` and
  `drupalSettings.editor.formats` (populated by `custom_paragraphs_page_attachments()`).
- `collectValues()` builds one object per row (`_index`, `_label`, then each field's value —
  editor `getData()` for CKEditor fields, the uploaded-file array for file fields, boolean for
  checkboxes); `updateStoredValue()` writes `JSON.stringify(collectValues())` into the hidden input
  when `storeAsJson` is true. Read that hidden field's JSON in your form submit handler.
