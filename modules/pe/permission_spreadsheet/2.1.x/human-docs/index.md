# Permission Spreadsheet — manual setup guide

**Permission Spreadsheet** (`permission_spreadsheet`) lets you export your site's
role → permission matrix to a spreadsheet, edit it in Excel (or any spreadsheet
app), and import it back to bulk‑assign permissions across roles. If you have a
site with many roles, or you regularly copy one role's permissions onto another,
this is a lot faster than clicking through Drupal's permissions form.

On **export** you get a downloadable sheet (XLSX, XLS, ODS, CSV, or TSV) with one
row per permission and one column per role. Columns A–C hold human‑readable
permission info, column D holds the machine permission name, and columns E onward
are the per‑role grant columns — a cell contains a "granted" mark (by default
`Y`) where the role has the permission. On **import** the module reads an edited
sheet back, compares it against the live site, shows a colour‑coded per‑role
preview of exactly what will be granted and revoked, and applies the changes only
when you confirm.

The module is built on the PhpSpreadsheet library and adds Export and Import
operations under **People**, plus a small settings form. **Admin (super‑user)
roles are deliberately excluded** from both export and import — the module only
ever touches non‑admin roles, so it can never edit the permissions of a role
flagged as "is admin".

> **Security caution.** The **Import permission spreadsheet** permission is
> powerful: whoever holds it can grant *any* permission (including
> `administer users`, `administer permissions`, or `administer modules`) to any
> non‑admin role, and Drupal does not flag it with its usual "grants elevated
> access" warning. Treat it as equivalent to *Administer permissions* and grant it
> only to fully trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (PhpSpreadsheet
   comes along) and enable it.
2. [Configuration](configuration/index.md) — the settings form, the export and
   import screens, and the exact spreadsheet layout the importer expects.

## Where it lives in the admin menu

- **Export:** People → Permissions → Spreadsheet export
  (`/admin/people/permissions/spreadsheet/export`).
- **Import:** People → Permissions → Spreadsheet import
  (`/admin/people/permissions/spreadsheet/import`).
- **Settings:** Configuration → People → Permission Spreadsheet
  (`/admin/config/people/permission_spreadsheet`).
