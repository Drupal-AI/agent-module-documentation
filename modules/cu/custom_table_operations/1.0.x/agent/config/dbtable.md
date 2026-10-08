<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `dbtable` config entity & its definition forms

## Install & enable

```bash
composer require drupal/custom_table_operations
drush en custom_table_operations -y
```

Core only — no module dependencies, no libraries. `configure` route is
`entity.dbtable.collection`. All access is the core permission
**`administer site configuration`**.

## The entity

`src/Entity/CustomTable.php` — `@ConfigEntityType(id = "dbtable")`, extends
`ConfigEntityBase`, implements the empty `CustomTableInterface`.

- `config_prefix = "dbtable"`, `admin_permission = "administer site configuration"`.
- Exported / stored properties (`config_export`): `id`, `label`, `primary_key`, `field_list`.
  `$primary_key` and `$field_list` are public arrays on the class (schema types them as
  `sequence`; in practice `primary_key` holds a single column name and `field_list` a list of
  column names).
- Handlers: `list_builder` → `DbTableListBuilder`; forms `add`/`edit` → `DbTableForm`,
  `delete` → `DbTableDeleteForm`.
- Links: `edit-form` `/admin/config/system/dbtable/{dbtable}`,
  `delete-form` `/admin/config/system/dbtable/{dbtable}/delete`.

Config schema (`config/schema/custom_table_operations.schema.yml`), type `config_entity`
`entity.dbtable.*`: `id` (string), `label` (label), `primary_key` (sequence),
`field_list` (sequence). Config object name is `custom_table_operations.dbtable.<id>`.

**Key semantics:** the `label` is not decorative — it must be the exact name of an existing
database table. The list builder and content controller pass `label`/`primary_key` straight into
the row routes.

## Collection / list builder

`Controller/DbTableListBuilder.php` (`ConfigEntityListBuilder`) — collection at
`/admin/config/system/dbtable`. Columns: **Table name** (label, linked to the data listing
`entity.dbtable.content` with `dbtable = label`, `pk = primary_key`), **Machine name** (id),
**Primary key**. An "Add table" local action (`links.action.yml`) points at the add form; a menu
link (`links.menu.yml`) sits under *Configuration → System* (`system.admin_config_system`).

## Add / edit definition — `DbTableForm`

`src/Form/DbTableForm.php` (`EntityForm`, injects `entity_type.manager`).

1. `label` textfield (the table name) with an AJAX `change` callback (`myAjaxCallback`) that
   re-renders the `table_field_details` fieldset (wrapper id `ajaxfield`).
2. `id` `machine_name` (uniqueness via `exist()` → entity query on `id`; disabled once not new).
3. On each build it checks `\Drupal::database()->schema()->tableExists($label)`. If the table is
   missing it shows an error message. If it exists it runs `DESCRIBE <label>` and offers:
   - `primary_key` — a **single-select** of the table's columns (required).
   - `field_list` — a **multi-select** of columns to display (required).
4. `save()` re-validates with `schema()->tableExists()` **and**
   `schema()->fieldExists(label, primary_key)`; on failure it messages the error and redirects to
   the collection without saving. Otherwise `$entity->save()` and a created/updated message.

## Delete definition — `DbTableDeleteForm`

`src/Form/DbTableDeleteForm.php` (`EntityConfirmFormBase`). Standard confirm step
(`getQuestion`/`getCancelUrl` → collection). `submitForm()` calls `$this->entity->delete()` — this
removes only the **config entity definition**, not the underlying database table or its rows.

## Routes (all require `administer site configuration`)

| Route | Path | Handler |
|---|---|---|
| `entity.dbtable.collection` | `/admin/config/system/dbtable` | `_entity_list: dbtable` |
| `entity.dbtable.add_form` | `…/dbtable/add` | `_entity_form: dbtable.add` |
| `entity.dbtable.edit_form` | `…/dbtable/{dbtable}` | `_entity_form: dbtable.edit` |
| `entity.dbtable.delete_form` | `…/dbtable/{dbtable}/delete` | `_entity_form: dbtable.delete` |

Row-data routes are covered in [../content/records.md](../content/records.md).

## Operating notes

- Register only tables you intend admins to edit; the maintainer warns explicitly **not to add
  Drupal core tables**.
- Because definitions are config entities they export with the site config
  (`custom_table_operations.dbtable.<id>.yml`) and deploy like any other config — but the target
  **table itself is not** part of that config and must exist on every environment.
- `DESCRIBE` is MySQL/MariaDB syntax; the schema-introspection path assumes such a backend.
