# Import & export taxonomy terms as CSV

Two admin forms, one permission (`administer term_csv_export_import`). No Drush, no config.

## Import — `/admin/config/content/term-csv-import`

Route `term_csv_export_import.import` (the module's `configure` route). A 3-step form:

1. **Paste CSV** into *Input*, choose a **Taxonomy** (an existing vocabulary or *create_new*),
   and optionally tick:
   - **Preserve Vocabularies on existing terms** — when a matching term already exists in a
     different vocabulary, keep it there instead of moving it.
   - **Preserve existing terms** — if a term (by `tid`, or by name+parent) already exists,
     **skip** it (no modification). Prevents tid collisions when importing from another install.
2. (Only if *create_new*) enter a **Name** and machine name for a new vocabulary.
3. Confirm the term count → **Import**.

### CSV format
Header is optional (the importer detects columns by count). Column sets:

```
# without IDs (6 or 7 cols):
name,status,description__value,description__format,weight,parent_name[,fields]

# with IDs (10 or 11 cols):
tid,uuid,name,status,revision_id,description__value,description__format,weight,parent_name,parent_tid[,fields]
```

- `status`: 1 (published) / 0.
- `parent_name` / `parent_tid`: parent term(s); **multiple parents separated by `;`**
  (e.g. `Europe;EU`). Empty = top level.
- `fields` (optional trailing column): any extra taxonomy fields, encoded with PHP
  `http_build_query()` (e.g. `field_color=red&field_code=EU`). Fields must already exist on
  the vocabulary or a warning is shown.
- Values are read with `fgetcsv`, so quote values containing commas.

Example (no IDs, with header):
```
name,status,description__value,description__format,weight,parent_name
Europe,1,,basic_html,0,
France,1,The country,basic_html,0,Europe
Paris,1,,basic_html,0,France
```

## Export — `/admin/config/content/term-csv-export`

A 2-step form: pick a **Taxonomy** and options, submit, then copy the CSV from the *CSV Data*
textarea. Options:
- **Include Term Ids in export** — adds `tid,uuid,…,revision_id,…,parent_tid` columns.
- **Include Term Headers in export** — prepends the header row.
- **Include extra fields in export** — appends the `http_build_query`-encoded `fields` column.

Export walks the vocabulary with `TermStorage::loadTree()` and emits one CSV row per term,
building `parent_name`/`parent_tid` from `loadParents()`.

## Programmatic use (scriptable — no UI, no Drush)

The controllers are plain classes you can instantiate directly:

```php
use Drupal\term_csv_export_import\Controller\ImportController;
use Drupal\term_csv_export_import\Controller\ExportController;

// IMPORT into an existing vocabulary $vid from a CSV string.
$csv = "name,status,description__value,description__format,weight,parent_name\n"
     . "Europe,1,,basic_html,0,\n"
     . "France,1,,basic_html,0,Europe\n";
$import = new ImportController($csv, $vid);       // $vid = vocabulary machine name
$import->execute($preserve_vocabularies = FALSE, $preserve_tids = FALSE);

// EXPORT vocabulary $vid to a CSV string.
$term_storage = \Drupal::entityTypeManager()->getStorage('taxonomy_term');
$export = new ExportController($term_storage, $vid);
$csv_out = $export->execute($include_ids = FALSE, $include_headers = TRUE, $include_fields = FALSE);
```

Notes:
- `ImportController::__construct()` parses the CSV; `execute()` creates/updates
  `taxonomy_term` entities and reports "Imported N terms." via messenger.
- When importing with IDs and `preserve_tids` off, existing tids are inserted directly into
  the taxonomy term tables to keep the same IDs.
- There is no batch API here — large imports run in one request.
