<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registering & managing custom tables

## Where the state lives

All registrations are stored in the **`view_custom_table.tables`** config object (a
`config_object`, not a config entity). Each registered table is a top-level key equal to the
table name, mapping to:

| Key | Meaning |
|---|---|
| `table_name` | The real DB table name. |
| `table_database` | The database **connection key** (from `settings.php` `$databases`); `default` for the main DB. |
| `description` | Human label shown in the admin list. |
| `column_relations` | **PHP-serialized** array `column => target` where target is an entity type id or another custom table name (`serialize([])` = `a:0:{}` when none). |
| `created_by` | UID of the creator (used by the "own" permission). |

Example (`drush config:get view_custom_table.tables`):

```yaml
sales_report:
  table_name: sales_report
  table_database: default
  description: 'Sales report'
  column_relations: 'a:1:{s:3:"uid";s:4:"user";}'
  created_by: '1'
```

## Admin UI (routes)

| Route | Path | Permission |
|---|---|---|
| `view_custom_table.customtable` (configure) | `/admin/structure/views/custom_table` | `administer own custom table in views` |
| `view_custom_table.customtable_all` | `/admin/structure/views/custom_table/all` | `administer all custom table in views` |
| `view_custom_table.addcustomtable` | `/admin/structure/views/custom_table/add` | `add custom table in views` |
| `view_custom_table.editcustomtable` | `/admin/structure/views/custom_table/edit/{table_name}` | `add custom table in views` |
| `view_custom_table.edittablerelations` | `/admin/structure/views/custom_table/relations/{table_name}` | `add custom table in views` |
| `view_custom_table.removecustomtable` | `/admin/structure/views/custom_table/remove/{table_name}` | `remove custom table in views` |

The **Add** form (`AddViewsCustomTable`) is multi-step: pick the database + table name (it
validates the table exists via `$connection->schema()->tableExists()` and isn't already
registered), then optionally declare column relations, then it writes the entry with
`config.factory->getEditable('view_custom_table.tables')->set("<table>.table_name", …)->…->save()`
(relations are `serialize()`d). **Edit Table Relations** re-maps numeric columns to entities /
other custom tables.

## Registering without the UI (drush / config)

```php
$c = \Drupal::configFactory()->getEditable('view_custom_table.tables');
$c->set('sales_report.table_name', 'sales_report')
  ->set('sales_report.table_database', 'default')
  ->set('sales_report.description', 'Sales report')
  ->set('sales_report.column_relations', serialize(['uid' => 'user']))
  ->set('sales_report.created_by', '1')
  ->save();
// Rebuild Views data so the new base table appears:
\Drupal::service('views.views_data')->clear();   // or `drush cr`
```

Requirements enforced by the module: the table must **exist**, have a **primary key**, and any
column used as an entity/table relation must be **numeric**. A table in a non-default database
can only relate to tables in that same database.

## Permissions (`view_custom_table.permissions.yml`)

- `add custom table in views` — add/edit registrations and relations.
- `remove custom table in views` — delete a registration.
- `administer own custom table in views` — manage the tables you created (`created_by`).
- `administer all custom table in views` — manage every registration.
