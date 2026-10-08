<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Table Operations (custom_table_operations) — agent index

Registers existing database tables as a config entity (`dbtable`) and gives admins a UI to
**view / add / edit / delete rows** of those tables. Package `Custom`. No module dependencies
(core only). Core requirement `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0.
No custom permissions, no services, no Drush, no hooks (empty `.module`).

- **The `dbtable` config entity, the definition form, routes & permissions** →
  [config/dbtable.md](config/dbtable.md)
- **The row-level CRUD: listing controller + add/edit/delete forms** →
  [content/records.md](content/records.md)

## What it actually is

- One **config entity type** `dbtable` (`src/Entity/CustomTable.php`, `@ConfigEntityType`),
  `config_prefix = "dbtable"`, `admin_permission = "administer site configuration"`. Exported
  keys: `id`, `label`, `primary_key`, `field_list`. The **`label` must equal a real DB table
  name**; `primary_key` is one column; `field_list` is the columns to display.
  Interface `CustomTableInterface` (empty, extends `ConfigEntityInterface`).
- **List builder** `Controller/DbTableListBuilder.php` — collection table (label/machine
  name/primary key), row label links to the data listing.
- **Content controller** `Controller/TableContentController::Listing()` — renders all rows of the
  chosen table (core DB `select`) with Edit/Delete links and an Add action.
- **Forms**: `Form/DbTableForm.php` (add/edit the definition — runs `DESCRIBE` to populate the
  primary-key + field selects), `Form/DbTableDeleteForm.php` (delete the definition),
  `Form/TableContentForm.php` (add/edit a row — `insert`/`update`),
  `Form/TableContentDeleteForm.php` (confirm delete a row — `delete`).
- **Config schema** `config/schema/custom_table_operations.schema.yml` for `entity.dbtable.*`.

## Routes (all `_permission: administer site configuration`)

Base path `/admin/config/system/dbtable` (menu link under *Configuration → System*):

- `entity.dbtable.collection` — list (`_entity_list: dbtable`).
- `entity.dbtable.add_form` / `edit_form` / `delete_form` — definition CRUD (`{dbtable}`).
- `entity.dbtable.content` — `…/{dbtable}/{pk}/list` — row listing (controller).
- `entity.dbtable.content_add_form` — `…/{dbtable}/{pk}/add`.
- `entity.dbtable.content_edit_form` — `…/{dbtable}/{pk}/update/{cid}`.
- `entity.dbtable.content_delete` — `…/{dbtable}/{pk}/delete/{cid}` (confirm form).

## Notes

- Access is uniformly `administer site configuration` (a trusted-admin permission); the module
  ships **no permission of its own** despite the config being CRUD over raw tables.
- The listing/CRUD read the **live table schema** at definition time (`DESCRIBE <table>`) and
  operate on whatever real table the `label` names. Do **not** register core tables.
- Row forms make every displayed column `#required`; the add form rejects a duplicate primary key.
