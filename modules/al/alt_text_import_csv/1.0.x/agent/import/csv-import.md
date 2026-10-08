<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSV import: form, batch, URL→entity matching, results

Full pipeline for the import route. Source: `src/Form/AltTextImportForm.php`,
`src/AltTextImportBatch.php`, `src/AltTextImporter.php`, `src/HostEntityItem.php`,
`src/Controller/ImportResultsController.php`.

## Install / enable

```
composer require drupal/entity_usage drupal/multivalue_form_element
drush en alt_text_import_csv -y
```

Grant `update image alt texts via csv files` to run imports; `administer alt_text_import_csv` to
change settings. Both are `restrict access: true`. The import form is menu-linked under
*Configuration › Media* (`alt_text_import_csv.links.menu.yml`); Import/Settings tabs come from
`alt_text_import_csv.links.task.yml`.

## CSV format

Three columns, in order: **page URL, image URL, alt text**. A header row is allowed — `processRow()`
skips row 0 when neither its page URL nor its image URL passes `FILTER_VALIDATE_URL`. Delimiter is a
form field (default `,`, maxlength 2).

## The upload form — `AltTextImportForm`

- `getFormId()` → `alt_text_import_csv_form`. Injects only `entity_type.manager`.
- `csv_file`: `managed_file`, required, `#upload_validators` = `file_validate_extensions => ['csv']`
  + `file_validate_size => [Environment::getUploadMaxSize()]`. `#upload_location` is
  `public://metatag_import_export_csv/` (a copy-paste leftover directory name, but the CSV is stored
  under `public://`).
- `delimiter`: required textfield, default `,`.
- `submit`: danger button.
- `validateForm()` re-checks the file element manually (core doesn't — see d.o #2938441): the fid
  must be numeric > 0, the file must open, and the first line must contain the delimiter
  (`str_contains`), else a form error.
- `submitForm()` builds a `BatchBuilder`, adds one operation `AltTextImportBatch::processRow($fid,
  $delimiter)`, finish callback `AltTextImportBatch::finish`, and `batch_set()`s it.

## The batch — `AltTextImportBatch::processRow()`

Static callback, one row per invocation, using a manual file handle so it survives batch iterations:

- First run seeds `$context['sandbox']` (`handle`, `pointer_position`, `csv_line`) and resets the
  private tempstore key `results_<fid>` (collection `alt_text_import_csv`).
- Re-opens the file each iteration and `fseek()`s to the stored pointer; `feof` → `finished = 1`.
- Reads a row with `fgetcsv(stream, separator: $delimiter)`, advances `csv_line` and
  `pointer_position` (`ftell`).
- Row 0 that is not URLs → marked `header_skipped`, skipped.
- Empty image URL **or** empty alt text → silently skipped (no error row).
- Invalid page URL / invalid image URL (`FILTER_VALIDATE_URL`) → `addError()`.
- Otherwise calls the importer service, passing the two config flags
  (`no_page_url_match_update_all`, `media_only`); success is recorded, any thrown
  `\Exception` is caught and stored via `addError()`.

`addError()` appends `{line_number, row, message}` to the tempstore `results_<fid>` list.

`finish()`: adds a "Imported alt texts from N rows" message, notes a skipped header, and if any
failures were stored calls `sendReportMail()` (see [../config/settings.md](../config/settings.md)),
then `RedirectResponse`s to `alt_text_import_csv.import.results/{fid}`.

## URL → entity resolution — `AltTextImporter`

Service `alt_text_import_csv.alt_text_importer`. `importAltText($image_url, $page_url, $alt_text,
$no_page_url_match_update_all, $update_media_only)`:

1. `getImageFromUrl()` — takes `parse_url(... PHP_URL_PATH)`, strips base path +
   `PublicStream::basePath()`, strips an image-style prefix with regex `@styles/\w+/\w+/@`, builds
   `public://<path>`, and `file.repository->loadByUri()`. No match → `\InvalidArgumentException`.
   (Only `public://` files are resolvable; private-scheme images are not matched.)
2. `preparePath()` — `parse_url($page_url, PHP_URL_PATH)`, strips base path; `'/'` resolves to
   `system.site:page.front`.
3. `findHostEntities()` — `entity_usage.usage->listSources($file)` gives every referencing entity;
   with `media_only`, intersected to the `media` entity type. For each source it builds a
   `HostEntityItem($host_entity, $field_names)` (field names from `array_column($sources,
   'field_name')`) and tests `entityOrParentUsesPageUrl()`. Returns the matching items; if none match
   and `no_page_url_match_update_all` is TRUE, returns *all* sources instead.
4. `entityOrParentUsesPageUrl()` — recursively ascends the entity_usage source chain, comparing each
   entity's aliased canonical URL (`aliasManager->getAliasByPath($entity->toUrl())`) to the page path
   (canonical templates ending in `edit`, e.g. media, are skipped).
5. For each host item it loads each `field_name`'s `referencedEntities()`, and where a referenced
   file id equals the target file id, sets `->get('alt')->setValue($alt_text)` on that field delta,
   then `$host_entity->save()`. If no host was found, or the file was not on the matched entity, it
   throws `\InvalidArgumentException` (→ an error row).

Matching caveats (documented in the class): Entity Usage must report the reference (misses sitewide
blocks / embedded views), and the page URL must equal the entity's canonical alias.

## Results page — `ImportResultsController`

Route `alt_text_import_csv.import.results/{file}`. `content(FileInterface $file)` reads
`results_<fid>` from the **current user's** private tempstore and renders a `#type => 'table'`
(row number, page URL, image URL, error message — all auto-escaped by the table theme) plus an
"Import another" link. Title callback shows the file label.
