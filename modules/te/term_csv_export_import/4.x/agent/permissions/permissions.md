# Permissions

Defined in `term_csv_export_import.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Administer CSV Term Import | `administer term_csv_export_import` | Access to **both** the Import form (`/admin/config/content/term-csv-import`) and the Export form (`/admin/config/content/term-csv-export`). Marked `restrict access: true` because importing terms can create/modify taxonomy content (and, with IDs, write directly to term tables). |

There is only this one permission; it controls the entire module. Grant it to trusted
administrators only.
