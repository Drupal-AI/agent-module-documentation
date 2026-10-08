# Bulk generate / delete aliases

Pathauto ships **no Drush commands**; bulk actions are batch forms in the admin UI.

- **Bulk generate** — `/admin/config/search/path/update_bulk`
  (route `pathauto.bulk.update.form`, permission `administer pathauto` + `bulk update aliases`).
  Generates aliases for entities that don't have one (or regenerates all) after you add or
  change a pattern. Choose per entity type; option to only create missing vs regenerate all.

- **Bulk delete** — `/admin/config/search/path/delete_bulk`
  (route `pathauto.admin.delete`, permission `administer pathauto` + `bulk delete aliases`).
  Deletes all automatically-created aliases (e.g. before a re-import), with options per
  entity type and "all aliases including manual".

Bulk generate form:
![Bulk generate aliases](../../../../../../../screenshots/pathauto/1.15.x/bulk-generate.png)

Bulk delete form:
![Delete aliases](../../../../../../../screenshots/pathauto/1.15.x/bulk-delete.png)

Programmatic alternative (loop + generator service) for scripted regeneration: see
[../api/generate-alias.md](../api/generate-alias.md). Actions
`pathauto_update_alias_node` / `_user` are also registered (usable via Views Bulk
Operations / core actions).
