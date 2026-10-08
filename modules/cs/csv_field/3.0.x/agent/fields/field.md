<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `csv_file` field type and `csv_file_generic` widget

## Install & enable

```bash
composer require drupal/csv_field    # pulls drupal/papaparse ^1.0
drush en csv_field -y
```

Dependencies (from `csv_field.info.yml`): core **`file`** and contrib **`papaparse`**
(`papaparse:papaparse`). No settings form, no permissions, no Drush commands, no submodules.

## Field type — `CsvFileItem`

`src/Plugin/Field/FieldType/CsvFileItem.php` extends core `\Drupal\file\Plugin\Field\FieldType\FileItem`.

- Annotation: `id = "csv_file"`, `default_widget = "csv_file_generic"`,
  `default_formatter = "csv_file_table"`, `list_class = FileFieldItemList`,
  `constraints = {"ReferenceAccess", "FileValidation"}` — same access/validation constraints as a
  core file field.
- `defaultFieldSettings()` forces `file_extensions => 'csv'`.
- `fieldSettingsForm()` disables the file-extensions element (`#disabled = TRUE`) so editors
  cannot broaden it in the UI.
- `schema()` adds a `settings` column to field storage: `type => text`, `size => big`,
  `serialize => TRUE` — this holds the serialized per-item display configuration.

Add the field via *Structure → (bundle) → Manage fields → Add field → CSV File*, or in config a
`field.storage.*` / `field.field.*` pair with type `csv_file` (see the test fixture
`tests/modules/csv_field_test/config/install/` for a complete example on `node.blog_post`).

## Widget — `CsvFileWidget` (`csv_file_generic`)

`src/Plugin/Field/FieldWidget/CsvFileWidget.php` extends core `FileWidget` and implements
`TrustedCallbackInterface` (trusted callback: `updateSettingsAccess`). `formElement()` defers to
the parent, and the extra UI is built in the `#process` callback `process()`, which adds a
`settings` **details** element ("Display Configuration"). All values land in the item's serialized
`settings` array.

### Settings collected by the widget

| `settings` key | Element | Notes |
|---|---|---|
| `pageLength` | select 5 / 10 / 15 | Initial rows per page. `normalizePageLength()` caps legacy values >15 to 15, invalid → 5. |
| `lengthChange` | checkbox | Let end users change rows-per-page. |
| `responsive` | radios `childRow` / `childRowImmediate` | Expansion-button vs auto-expand for overflow columns. Default `childRow`. |
| `searching` | checkbox | Show a search field + Search button (filters on submit, not per keystroke). |
| `hideSearchingData` | checkbox | With searching: keep table + pagination hidden until a search is run. |
| `download` | checkbox | Show a CSV download link. |
| `centerContent` | checkbox | Center cell content. |
| `firstColumnRowHeader` | checkbox | Tag first-column cells as `<th>` instead of `<td>`. |
| `tableLabel` | textfield (255) | Short accessibility name for the table (unique landmark names). |
| `searchLabel` | textfield (100) | Accessible name for the search field. **Required** (via `validateSearchLabelRequired()`) when `hideSearchingData` is checked. |
| `downloadText` | textfield | Custom download-link text (only offered when the field description element exists; it hides the description). |
| `urls.autolink` | checkbox | Convert URL columns into links using left-neighbour text. |
| `urls.urlColumnNumber` | textfield | Comma-separated 1-based column numbers holding URLs (e.g. `3,5,8`). Validated by `validateUrlColumnNumbers()`: digits/commas only, each ≥ 2. |

Backport shim: a legacy top-level `settings['autolink']` is copied into `settings['urls']['autolink']`.

### CSV preview in the widget

When a file is already uploaded, `getCsvExampleRows()` opens it with `fopen()` + `fgetcsv()`,
de-duplicates repeated header names (appends ` (n)`), and returns the header row plus up to 5 data
rows. `process()` renders these as a preview `#type => table` with a checkbox per header column
(column 1 disabled — it can only be link text, not a URL column). The preview cells are output with
`htmlspecialchars($cell)`. The `csv_preview` library (`js/csv-preview.js`) syncs the checkboxes to
the hidden `urls.urlColumnNumber` textfield.

### Value normalization — `value()`

`value()` (the `#value_callback`) post-processes submitted values:

- A brand-new upload with no settings gets defaults
  `searching=1, pageLength=5, lengthChange=1, responsive=childRow, download=1, autolink=0`.
- Otherwise, the int-like keys (`searching, hideSearchingData, pageLength, lengthChange, download,
  autolink, firstColumnRowHeader`) are cast to `(int)`, and `pageLength` is run through
  `normalizePageLength()`.
- If `downloadText` is set it is mirrored into the item's `description` (the file description
  column), which the formatter can reuse as link text.

### Page-length helpers

`pageLengthOptions()` returns `[5, 10, 15]`. `normalizePageLength($v)` → 5 for null/empty/invalid,
15 for anything above 15, otherwise the matching option. Used by both the widget and the formatter,
and mirrored in `js/csv-field.js` (`normalizePageLengthSettings`) so legacy content is capped at
runtime without a data migration.

## What is stored

The uploaded file id(s) live in the normal file-field columns; the display choices live in the
extra serialized `settings` column added by `CsvFileItem::schema()`. Rendering of the actual table
happens entirely on the client — see [formatter.md](formatter.md).
