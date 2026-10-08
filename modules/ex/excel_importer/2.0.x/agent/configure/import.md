# Running an import

Route `excel_importer.import_form` → **`/excel-import`**, gated by permission `use excel_importer`.
Form: `Drupal\excel_importer\Form\ExcelImporterForm` (form id `excel_importer_form`). The import runs
**synchronously** inside `submitForm()` — there is no Batch API, so a large sheet blocks the request.

## The upload field

`buildForm()` renders one `managed_file` element plus a submit button:

| Property | Value |
|---|---|
| `#type` | `managed_file` |
| `#name` | `excel_file` |
| `#upload_validators` | `FileExtension` → `extensions: 'xlsx'` (only `.xlsx` accepted) |
| `#upload_location` | `public://content/excel_files/` |
| `#required` | `TRUE` |
| max size shown | `ini_get('upload_max_filesize')` (PHP limit, not enforced by the module) |

The `introduction` config value is printed above the field as `#markup`. The form sets
`enctype=multipart/form-data`.

## Spreadsheet contract

The file is loaded with `PhpOffice\PhpSpreadsheet\IOFactory::load()`. Layout the module expects:

- **One worksheet per content type.** The sheet *title* must equal a content-type machine name that
  is listed in `allowed_types` (see [settings.md](settings.md)). Sheets whose title is not an allowed
  type are skipped.
- **Row 2 is the header row** — each non-empty cell is a **field machine name** of that bundle
  (validated with `isValidField()` against `entityFieldManager->getFieldDefinitions('node', $bundle)`).
- **Rows after row 2 are data rows.** Row 1 is ignored (reserve it for a human label/title). Rows
  where every cell is blank are skipped (`isRowEmpty()`).
- **No column may be named `type`** — the importer sets `type` itself to the sheet's bundle.
- Cell→field mapping is by header position; column order is free. Only **single-value** fields are
  supported (multi-value fields are not handled).

## Validation

`validateForm()` loads the file and requires **at least one** worksheet whose title matches an
allowed content type, else sets a form error. A PhpSpreadsheet read exception is logged to the
`excel_importer` channel and surfaced as a messenger error.

`submitForm()` validates every data cell before creating anything; the **first failure aborts the
whole import** (`return FALSE`, error message names sheet/row/field):

| Check | Method | Rule |
|---|---|---|
| Field exists | `isValidField()` | header name must be a field definition of the bundle |
| Required provided | `isRequireFieldProvided()` | a required field must be non-empty |
| Numeric type | `isCorrectDataType()` | `integer` fields must be `is_numeric()` |
| Taxonomy ref valid | `isTaxonomyReference()` + `isValidTaxonomyReference()` | term name must resolve in the target vocabulary, unless the field's handler has `auto_create` |

## Value coercion → node creation

For each valid cell, `getCorrectValue()` converts the raw cell value:

- **Entity reference `taxonomy_term`**: look up a term by `name` + `vid` in the field's target
  vocabulary and use its `tid`. If the field handler allows `auto_create` and the term is missing, a
  new term is created (`createTaxonomyTerm()` → `Term::create()->save()`).
- **Entity reference `user`**: resolve by `mail` → `uid`. **Entity reference `node`**: resolve by
  `title` → `nid`.
- **`daterange`**: split the cell on a comma into `value` / `end_value` (trimmed).
- **`integer` / `float` / `decimal`**: empty → `0`.

Then, per data row, a node is created and saved:

```php
$node = $this->entityTypeManager->getStorage('node')->create($cells); // $cells includes 'type'
if (!strlen(trim((string) $node->getTitle()))) {
  $node->setTitle($node->type->entity->label() . ' ' . date('Y-m-d')); // title fallback
}
$node->save();
```

A success message reports the number of saved entries. Created nodes are owned by the current user
(no explicit owner is set) and no per-node access check is performed — the `use excel_importer`
permission is the gate.

## Notes / limits

- XLSX only (`.xls`, `.csv` are rejected by the extension validator despite the "Excel/CSV" framing).
- Google Sheets / Numbers XLSX exports can emit stray empty rows that confuse row indexing.
- The import is all-or-nothing per submission: one bad cell rolls the user back to a fresh upload.
