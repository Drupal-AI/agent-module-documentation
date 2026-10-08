<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Menu Export / Menu Import entities + Quick Action Settings

The configure route is `menu_migration.menu_migration` →
`/admin/config/development/menu-migration`, a menu block with three children:
**Menu Exports**, **Menu Imports**, **Quick Action Settings**.

## Config entity types

Two config entities hold reusable, Drush-triggerable migrations:

| Entity type id | Collection route | Config prefix |
|---|---|---|
| `mm_export_type` (Menu export) | `entity.mm_export_type.collection` | `menu_migration.mm_export_type.<id>` |
| `mm_import_type` (Menu import) | `entity.mm_import_type.collection` | `menu_migration.mm_import_type.<id>` |

`mm_export_type` `config_export`: `name`, `label`, `destination`, `destination_config`, `weight`
(id key is `name`). `mm_import_type` mirrors it with `source` / `source_config`.

### Export destination config

`destination` is a plugin id; `destination_config` is validated by schema keyed on it:

- **`codebase`** — writes files to disk. `destination_config`: `format`, `menus` (array),
  `export_path` (directory). CLI-capable.
- **`download`** — streams a downloadable file. `destination_config`: `format`, `menus` (single).
- **`another_menu`** — clones links into another menu (no format/file). `destination_config`:
  `menus` (source), `target_menu`, `create_target` (bool).

### Import source config

`source` is a plugin id; `source_config` keyed on it:

- **`codebase`** — reads files from disk. `source_config`: `format`, `menus` (array), `import_path`.
- **`file_upload`** — reads an uploaded file. `source_config`: `format`, `menus` (single).

`format` must be an existing Format plugin id: `json`, `yaml`, or `raw`.

## Quick Action Settings (simple config)

Form `menu_migration.quick_action_settings`; config object `menu_migration.quick_export`
(shipped in `config/install`):

```yaml
format: 'json'                                     # json | yaml
export_path: '../config/menu_migration/quick-export'
```

This is the default format + directory used by the `mmqe` / `mmqi` **quick** Drush commands
(which do not read the config entities). Read/set it with drush:

```bash
drush cget menu_migration.quick_export
drush cset menu_migration.quick_export format yaml -y
drush cset menu_migration.quick_export export_path '../config/menu_migration/quick-export' -y
```

## Create an export entity programmatically

```php
\Drupal\menu_migration\Entity\ExportType::create([
  'name' => 'main_to_codebase',
  'label' => 'Main menu to codebase',
  'destination' => 'codebase',
  'destination_config' => [
    'format' => 'json',
    'menus' => ['main'],
    'export_path' => '../config/menu_migration/quick-export',
  ],
])->save();
```

`ImportType::create([... 'source' => 'codebase', 'source_config' => [...] ])` is the mirror.
Trigger with `drush mme main_to_codebase` (export) / `drush mmi <id>` (import), or the
*Export* / *Import* operation link on the collection page.

## Read back / list

```bash
drush config:get menu_migration.mm_export_type.main_to_codebase
drush pm:list --status=enabled | grep menu_migration
```

Entities are weighted and drag-orderable on their listing pages.
