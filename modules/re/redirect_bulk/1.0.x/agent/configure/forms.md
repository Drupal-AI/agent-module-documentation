# Redirect Bulk — forms, routes, CSV format

Both forms create standard `\Drupal\redirect\Entity\Redirect` entities. No config object/schema.

## Routes (`redirect_bulk.routing.yml`)
| Route | Path | Form/Controller | Access |
|---|---|---|---|
| `redirect_bulk.form` | `/admin/config/search/redirect/add-bulk` | `RedirectBulkForm` | `administer bulk redirects` |
| `redirect_bulk.csv_form` | `/admin/config/search/redirect/add-csv` | `CsvForm` | `administer bulk redirects` |
| `redirect_bulk.node_autocomplete` | `/node/autocomplete` | `RedirectBulkController::handleAutocomplete` | `access content` |

Action links "Add Bulk redirects" (on `redirect.list`) and "Import CSV" (on `redirect_bulk.form`).
`configure` route = `redirect_bulk.form`.

## Manual bulk form (`RedirectBulkForm`)
- AJAX repeater: "Add redirect" (`addOne`) / per-row "Remove" (`removeRedirect`) rebuild the form.
- Per row: `source` (Path, required), `destination` ("To", required, autocomplete →
  `redirect_bulk.node_autocomplete`), `status_code` (select, `redirect_status_code_options()`,
  default 301), and on multilingual sites `language`.
- `validateForm` rejects, per row: empty source/destination; duplicate source within the form;
  `source == '<front>'`; `#` fragments in source; source starting with `?` or `/`; destination
  starting with `/`; invalid source path; self-redirect (source URL == destination URL); and a source
  that already has a redirect (error links to the existing redirect's edit form, matched via
  `Redirect::generateHash($path,$query,$language)`).
- `submitForm` destination handling: `UrlHelper::isExternal($destination)` → used verbatim (external);
  else if it contains `node` → `entity:<path>`; else `internal:/<path>`. Query string is parsed off the
  source. Saves a `Redirect` per row, then redirects to `redirect.list`.

## CSV importer (`CsvForm`)
- Single `file` element; description: `from, to, code, langcode (langcode is optional)`.
- `submitForm` saves the upload with `file_save_upload('import', ['FileExtension'=>['extensions'=>'csv']], ...)`,
  reads it, `parseCsv()` (splits lines, `str_getcsv`, needs ≥2 columns).
- Per-row `validateRedirect()`: skips rows already redirected (error links existing); empty from/to;
  from == to; code must be in 300–307 if given; langcode must be an existing language if given.
- Destination: external kept as-is, else `internal:/<path>`. Status code falls back to
  `redirect.settings:default_status_code` (or 301); langcode falls back to `und`.
- Reports `@count imported` / `@count could not be processed`.

## Notes
- Source paths are stored without a leading slash; `clearUrl()` trims slashes/whitespace.
- The uploaded CSV is saved as a **permanent** managed file (`$file->setPermanent()`), so imported files
  persist in the files table.
- External destinations are permitted (open redirect) — this mirrors the Redirect module itself and is
  gated by `administer bulk redirects` (same trust level as core's non-restricted `administer redirects`).
