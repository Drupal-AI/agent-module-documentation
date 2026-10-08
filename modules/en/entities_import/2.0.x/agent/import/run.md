<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import run flow — upload, parse, map, batch-save

How an upload becomes entities. Source: `src/Form/FileUploadForm.php`, `src/ReadExcel.php`,
`src/GenerateExcelData.php`, `src/DataStorage.php`, `src/FileDetails.php`, `src/ImportUtilities.php`.

## 1. Upload form (`FileUploadForm`)

`buildForm()` renders a single `managed_file` element `file`, required, with
`#upload_validators => ['file_validate_extensions' => ImportUtilities::FILE_UPLOAD_FORMAT]` where
`FILE_UPLOAD_FORMAT = ['xlsx xls csv']`. Form id `entities_file_upload`; `validateForm()` is empty. The
import-type is chosen by the `type` query argument (set by the "Import {id}" link on the edit form).

## 2. Read the spreadsheet (`ReadExcel::readExcelData($uri)`)

Resolves the file's real path with `file_system->realpath()` and loads it with
`PhpOffice\PhpSpreadsheet\IOFactory::load()`. Iterates the active sheet's rows; date cells use
`getFormattedValue()`, others `trim(getValue())`. Row layout it assumes:

- **Row 1** → `header` (human labels, used only for error messages).
- **Row 2** → `fields` (the actual entity field machine names = column keys).
- **Rows 3+** → data; each is `array_combine(fields, cells)`.

So the machine-name header lives on the **second** row, and data starts on row 3 (batch reports
`row = key + 3`).

## 3. Map rows to field arrays (`GenerateExcelData::getExcelArrayIndex()`)

For each cell it looks up the field type/cardinality/target bundle via `FieldDetails` and builds the
per-entity array:

- **Number** (`float`/`integer`/`decimal`) — `validateField()` records a per-row `error` if a value is
  not numeric.
- **datetime** / **daterange** — parsed with `strtotime()` → `Y-m-d` (`generateDateArray`,
  `generateDateRangeArray`; range split on `|`).
- **entity_reference** (to `node`/`taxonomy_term`) — resolves the target by bundle + title/name via
  `EntityDetails::checkEntityExistsByProperties()` (`loadByProperties`) to an entity id
  (`generateEntityReferenceArray` / `...CardinalityArray` for unlimited cardinality).
- **entity_reference_revisions / paragraph** — `generateParagraphArray()` decodes an encoded cell:
  paragraph items split on `|`, fields within an item on `#`, and `field*value` on `*`; it then recurses
  `getExcelArrayIndex()` for the paragraph bundle.
- **image/file** — value(s) kept as filenames with `type` marker; multi-value split on `|`
  (`ImportUtilities::SEPERATOR_MULTIVALUE_FIELD`).
- Other multi-value fields split on `|`; everything else stored as the raw trimmed value.

## 4. Batch build & save

`FileUploadForm::submitForm()` loads the `entities_import_type`, resolves the target entity
(`node` for `content_type`, else `taxonomy_term`) and bundle, splits `unique_value_fields` on newlines,
sets `file_folder_path = public:// . file_path`, then queues one Batch operation per row calling
`['\Drupal\entities_import\DataStorage', 'save']`. `finished` callback:
`DataStorage::entities_import_batch_finished()` (reports total created/updated and per-row errors).

`DataStorage::save($item, &$context)`:

- Builds a properties array from the unique fields (`CommonUtilities::generatePropertiesArray()`) and
  looks for an existing entity (`EntityDetails::checkNodeExistsByProperties()` = `loadByProperties`).
- **No match** → `Node::create(['type'=>bundle])` / `Term::create(['vid'=>bundle])`; **match** → load and
  update (adding/using a translation when `language_code` is set, via `EntityTranslationDetails`).
- Per field: paragraphs → `getParagraphDetails()`/`updateParagraphDetails()` (creates/updates
  `Paragraph` entities); file/image → `FileDetails::create()/update()`; everything else → `set()`.
- Title/name set from the `title` column (or the joined unique fields); owner forced to **`uid = 1`**;
  then `save()`.

## Field/paragraph cell encoding (cheat-sheet)

- Multi-value scalar or reference field: `a|b|c`.
- Date range: `start|end` (each parsed by `strtotime`).
- Paragraph field: `field1*val1#field2*val2 | field1*valA#field2*valB` (one paragraph per `|`, fields per
  `#`, name/value per `*`).

## Files & language notes

- `FileDetails::create($filename, $folder)` creates a permanent managed `File` at
  `public://{file_path}/{filename}` — it records the URI only; place the actual file on disk manually
  (README step 5). `update()` reuses/renames existing fids and deletes surplus ones.
- Language: with the `language` module, the import type's `language_code` drives creation of the entity
  or of a translation of a matched entity.
