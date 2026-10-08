# Configure — Permission Spreadsheet

## Settings form
Route `permission_spreadsheet.settings` → `/admin/config/people/permission_spreadsheet`,
permission `administer permission spreadsheet`. Config object `permission_spreadsheet.settings`.

Defaults (`config/install/permission_spreadsheet.settings.yml`):
```yaml
import:
  text_revoked: ''          # newline-separated list of cell values treated as "revoked"
  auto_preview: true        # auto-generate the diff preview when a file is uploaded
export:
  filename: permissions     # download filename (no extension); supports tokens
  sheet_title: Permissions  # Excel sheet title; supports tokens
  text_granted: 'Y'         # mark written for a granted permission
  text_revoked: ''          # mark written for a revoked permission (may be empty)
```
`export.filename` and `export.sheet_title` render tokens (a `token_tree_link` is shown on the form).

## Export (`permission_spreadsheet.export`, perm `export permission spreadsheet`)
`/admin/people/permissions/spreadsheet/export`. Choose an output format (xlsx/xls/ods/csv/tsv) and
download. The sheet is generated with PhpSpreadsheet via `PhpSpreadsheetHelperTrait::createWriter()`
(tsv is emitted as a Csv writer with a tab delimiter). **Only non-admin roles** get a column.

## Import (`permission_spreadsheet.import`, perm `import permission spreadsheet`)
`/admin/people/permissions/spreadsheet/import`. Upload an xlsx/xls/ods/csv/tsv file (managed_file,
extensions `xlsx xls ods csv tsv`). **Preview** (or auto-preview) shows a per-role table of the
diff (`+ Granted` / `- Revoked`). **Import** submit applies it.

### Spreadsheet layout the importer expects
- **Column D (4th):** permission machine name (must stay in column D).
- **Columns A–C:** display-only (module name / title / provider) — reorderable, ignored on import.
- **Row 1 of columns E+:** the role ID for each grant column. Columns are read left-to-right and
  **stop at the first empty header cell** (columns after a gap are ignored).
- **A cell is "granted"** when, after trimming, it is non-empty AND not in the `import.text_revoked`
  list; otherwise it is "revoked". This becomes `(int) $is_granted` per role/permission.
- Only differences vs. current state are applied, per role, via `user_role_change_permissions()`.
- Role IDs in the sheet that are not present (or that map to an admin role) are ignored.

## Drush
No Drush commands. Edit settings with `drush cset permission_spreadsheet.settings ...`. The
import/export operations themselves are UI-only (no Drush entry point).
