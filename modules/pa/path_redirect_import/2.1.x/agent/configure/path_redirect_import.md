# Configure — bulk import / delete / export redirects

This module has **no settings form**. It adds two forms (as tabs on the Redirect admin
listing) that operate on `redirect` entities. `configure` in info.yml points at
`entity.redirect.migrate`.

## Routes

| Route | Path | Form | Permission |
|---|---|---|---|
| `entity.redirect.migrate` | `/admin/config/search/redirect/migrate` | `MigrateRedirectForm` | `administer redirects` |
| `entity.redirect.export` | `/admin/config/search/redirect/export` | `ExportRedirectForm` | `administer redirects` |

Both permissions come from the **redirect** module; path_redirect_import defines no
permissions of its own. Menu tabs "Migrate" and "Export" hang off `redirect.list`.

## CSV format

Header row is **required** and must be exactly these four columns:

```
source,destination,language,status_code
```

Sample rows (from the on-form sample table):

| source | destination | language | status_code |
|---|---|---|---|
| `source-path` | `<front>` | `und` | `301` |
| `source-path-other?param=value` | `my-path` | `en` | `302` |
| `my-source-path` | `https://example.com` | `und` | `302` |

Column semantics:

- **source** — the old path to redirect *from*. A leading `/` is stripped; query strings
  are parsed and kept. This plus **language** form the row's unique id.
- **destination** — where to redirect *to*: an internal path, `<front>`, or an absolute URL.
- **language** — langcode (e.g. `en`, `und`). Part of the redirect hash / row key.
- **status_code** — HTTP code (301, 302, …). If empty the migration defaults it to **301**.

## Import (Migrate tab)

Upload the CSV on `entity.redirect.migrate` and submit **Migrate data**. Validation runs per
line and rejects the file if: headers don't match the four labels; any cell is not valid
UTF-8; any cell is empty/null; or `source` equals `destination`. A failing file is deleted.

On success the file is moved to `temporary://path_redirect_import/migrate.csv` and the
`path_redirect_import` migration runs as a **batch** (via `MigrateBatchExecutable`) with
`update = 1`, so re-importing the same source+language **updates** the existing redirect
rather than creating a duplicate. New `redirect` entities are created with `uid = 1`.

## Delete (same tab)

Tick **"Delete redirects defined in the spreadsheet"** before submitting. Instead of
importing, the module computes each row's hash with `Redirect::generateHash($path, $query,
$language)`, loads matching redirects, and forwards to Redirect's
`entity.redirect.multiple_delete_confirm` form for confirmation.

## Export (Export tab)

`entity.redirect.export` submits a batch (`RedirectExport::getBatchOperations()`) that writes
all existing redirects to a CSV using the same `source,destination,language,status_code`
structure — the inverse of import.
