# Permissions

Defined in `excel_importer.permissions.yml`. Both are flagged `restrict access: true`, so Drupal
warns when granting them and they are **not** given to anonymous/authenticated by default — a site
admin must grant them deliberately.

| Permission | Gates | Notes |
|---|---|---|
| `use excel_importer` | Route `excel_importer.import_form` (`/excel-import`) — upload a spreadsheet and create nodes in bulk. | This is who can import. It lets the holder create nodes of any content type listed in `allowed_types`, regardless of the normal per-bundle *create content* permissions. |
| `administer excel_importer` | Route `excel_importer.admin_settings` (`/admin/config/content/excel_importer`) — edit `allowed_types` and the intro text. | Controls which bundles importers may target. |

Grant example:

```sh
drush role:perm:add content_editor 'use excel_importer'
drush role:perm:add administrator 'administer excel_importer'
```
