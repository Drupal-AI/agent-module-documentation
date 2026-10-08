# Import UI & CSV format

The module has **no settings form / config entity** (info.yml declares no `configure`
route; there is no `config/` directory). "Configuration" here means the import form and
the CSV format it expects.

## Routes & permission (`csv_importer.routing.yml`)

| Route | Path | Handler | Purpose |
|---|---|---|---|
| `csv_importer.admin` / `csv_importer.import` | `/admin/content/csv-importer` (and `/import`) | `ImporterForm` | The import form |
| `csv_importer.history` | `/admin/content/csv-importer/history` | `HistoryController::history` | List past imports |
| `csv_importer.revert` | `/admin/content/csv-importer/revert/{import_id}` | `HistoryController::revert` | Delete entities created by an import |

All four require the single permission **`access csv importer`** (`restrict access: true`,
title "Access CSV Importer"). Menu link "Import CSV" is added under Content
(`system.admin_content`).

## Using the form

1. Go to Content > Import CSV.
2. **Select entity type** — options are every *content* entity type (nodes, users, taxonomy
   terms, media, comments, custom content entities…). This is an AJAX select.
3. **Select entity bundle** — shown only for entity types that have bundles; required then.
4. **Select delimiter** — one of `,` `~` `;` `:` (default `,`).
5. **Select CSV file** — a `managed_file` limited to the `csv` extension, auto-uploaded. Must
   be **UTF-8**.
6. Press **Import**. Work runs through the Batch API.

On submit the form validates that the CSV header contains **all required fields** of the
bundle (except the bundle key itself). If any are missing it shows
"Your CSV has missing required fields: …" and imports nothing.

## CSV format

- **Row 1 = header** of target field machine names (e.g. `title`, `body`, `field_tags`).
- Each subsequent row = one entity.
- Empty cells are skipped.

### Column → field-property mapping (pipe `|`)

A header cell may pipe several names to fan one column value into multiple properties of a
composite field, e.g. header `body|value|format` sets `body[value]`, `body[format]`, … from
that column. A plain header (`title`) sets the field directly. Repeating the same plain field
header across columns collects the values into an array.

### Multi-value cells (`values()` / `multiple()`)

A **cell value** matching `values(a+b+c)` or `multiple(a+b+c)` (regex
`ImporterInterface::REGEX_MULTIPLE`) is split on `+` into an array, populating a multi-value
field from a single cell.

### File / image columns

If a cell is a string that is a valid stream-wrapper URI (`public://…`, `private://…`) or an
`http`/`https` URL, the file is downloaded (`file.repository`, `FileExists::Replace`, saved to
the site default scheme) and the cell is replaced by the new **file ID** (single) or an array
of `{target_id: …}` (multiple). Bare local filesystem paths are **rejected** to avoid
disclosing arbitrary server files.

### Create vs. update, translations

- If a row supplies the entity **id key** (e.g. `nid`, `uid`, `tid`) and that entity exists,
  it is **loaded and updated**; otherwise a new entity is **created**.
- On a multilingual site a `langcode` column targets a translation: an existing/added
  translation for that language is set instead of the default-language values.

## History & revert

Every successful import is logged to the `csv_importer_history` DB table (file name, path,
entity type/bundle, imported count, serialized entity IDs, timestamp, status). The history
page lists them; the revert link (`status = 0` rows only) deletes the entities that import
created and flips its status to `1` (reverted). There is no config to enable this — the table
is created by `hook_install` / `hook_schema`.
