# Configuration

Permission Spreadsheet works with sensible defaults straight away, but a small
settings form lets you tune the export marks, filename, and import behavior. This
page covers that form and then walks through the export and import screens
themselves — including the exact spreadsheet layout the importer expects.

## The settings form

1. Log in as a user with the **Administer permission spreadsheet** permission.
2. Go to **Configuration → People → Permission Spreadsheet**
   (`/admin/config/people/permission_spreadsheet`).

The form controls both export and import defaults:

- **Import — "revoked" texts** — a newline‑separated list of cell values that
  should count as a *revocation* on import. Any cell that, after trimming, is
  non‑empty and is *not* one of these values is treated as *granted*. Leave it
  empty to treat every empty cell as "revoked" and every non‑empty cell as
  "granted".
- **Import — auto‑preview** — when on (the default), uploading a file
  immediately generates the diff preview; turn it off if you'd rather click to
  preview.
- **Export — filename** — the download filename (without extension). Defaults to
  `permissions` and **supports tokens** (e.g. include the site name or date), so
  you can produce dated snapshots. A token browser is shown on the form.
- **Export — sheet title** — the title written inside the Excel sheet. Defaults to
  `Permissions` and also **supports tokens**.
- **Export — "granted" mark** — the value written into a cell for a granted
  permission. Defaults to `Y`; change it to `x`, `1`, or whatever you prefer.
- **Export — "revoked" mark** — the value written for a non‑granted permission.
  Empty by default (so ungranted cells are simply blank).

Click **Save configuration** to store your choices.

## Exporting

1. Go to **People → Permissions → Spreadsheet export**
   (`/admin/people/permissions/spreadsheet/export`), which requires the **Export
   permission spreadsheet** permission.
2. Choose an output format — **xlsx, xls, ods, csv, or tsv** — and download.

The generated sheet has one column per **non‑admin** role and one row per
permission. This is your starting point for editing.

## Importing

1. Go to **People → Permissions → Spreadsheet import**
   (`/admin/people/permissions/spreadsheet/import`), which requires the **Import
   permission spreadsheet** permission.
2. Upload an edited `xlsx`, `xls`, `ods`, `csv`, or `tsv` file.
3. Review the **preview** — a per‑role table showing every change as
   `+ Granted` or `- Revoked`. Nothing is applied until you submit.
4. Click **Import** to apply the changes. Under the hood the module calls Drupal's
   own `user_role_change_permissions()` for each affected role, applying only the
   differences from the current state.

### The spreadsheet layout the importer expects

The importer reads a specific structure, so keep these rules in mind when editing:

- **Column D** must hold the **permission machine name** — this is how each row is
  identified. Don't move it.
- **Columns A–C** are display‑only (module name, title, provider). They are
  ignored on import, so you can reorder or delete them freely.
- **Row 1 of columns E onward** must hold the **role ID** for each grant column.
  Columns are read left‑to‑right and reading **stops at the first empty header
  cell** — so any columns after a gap are ignored (a handy way to exclude roles
  you don't want to touch).
- **A cell counts as "granted"** when, after trimming, it is non‑empty and not one
  of the configured "revoked" texts; otherwise it counts as "revoked".
- Role IDs that don't exist, or that map to an admin (super‑user) role, are
  ignored — admin roles are never modified.

### Common workflows

- **Copy one role's permissions onto another** — duplicate its column and give the
  copy the target role's ID in row 1.
- **Only touch some roles** — delete the columns for roles you want to leave
  alone (or leave a gap so later columns are ignored).
- **Only touch some permissions** — delete the rows you don't want to change.

## Setting values without the UI

The settings can be edited with Drush; the export/import operations themselves are
UI‑only:

```bash
drush cset permission_spreadsheet.settings export.text_granted 'x' -y
drush cset permission_spreadsheet.settings import.auto_preview 0 -y
```
