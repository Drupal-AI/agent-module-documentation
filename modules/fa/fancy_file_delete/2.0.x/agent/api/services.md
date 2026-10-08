<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, VBO actions, query logic

## Services (`fancy_file_delete.services.yml`)

### `fancy_file_delete.batch` — `FancyFileDeleteBatch`

The one entry point every workflow (Drush, Manual form, VBO actions) uses.

```php
/** @var \Drupal\fancy_file_delete\FancyFileDeleteBatch $batch */
$batch = \Drupal::service('fancy_file_delete.batch');
// $values: array of FIDs (numeric) and/or filesystem paths (unmanaged).
// $force:  bool — true drops file_managed + file_usage rows + entity directly.
// $ui:     bool — true = interactive UI batch; false = CLI (drush_backend_batch_process()).
$batch->setBatch($values, $force, $ui = TRUE);
```

`process($value, $force, &$context)` per item:
- **numeric** `$value` → `File::load($fid)`. If `$force`: delete `file_managed` + `file_usage`
  rows for that fid, then `$storage->delete()` the entity. Else: `$file->delete()` — when the
  file is still referenced this returns an array and the file is **skipped** with a notice.
- **non-numeric** `$value` → treated as an unmanaged filesystem path: delete its
  `unmanaged_files` row and `unlink` the file.

### `fancy_file_delete.unmanaged_files` — `UnmanagedFilesService`

Populates the `unmanaged_files` entity table used by the UNMANAGED view.

- `updateView()` — scan chosen dirs, diff against `file_managed`, sync the `unmanaged_files` table.
- `getDirs()` — all public/private directories + sub-directories.
- `getChosenDirs()` / `setChosenDirs(array)` — the directory subset to scan; persisted in
  State key `fancy_file_delete_unmanaged_chosen_dirs` (defaults to `['public://']`).

## VBO actions (`src/Plugin/Action/`)

Both extend `ViewsBulkOperationsActionBase`; used on the two module views.

| id | label | force |
|---|---|---|
| `delete_files_action` | Delete Files | no |
| `delete_files_action_force` | FORCE Delete Files (No Turning Back!) | yes |

`executeMultiple()` maps each selected entity to a value — `File` → its id, `UnmanagedFiles`
→ its `getPath()` — then calls `setBatch($values, $force)`.

## Orphan detection query (`ffd_orphan_filter`)

Registered on `file_managed` via `hook_views_data_alter()` (title "Orphan File Delete") and
implemented in `Plugin/views/filter/FancyFileDeleteOrphanFileFilter`. An orphan = a managed
file whose only usage is a `node` reference to a node that no longer exists:

```sql
SELECT fm.* FROM file_managed fm
  LEFT OUTER JOIN file_usage fu ON fm.fid = fu.fid
  LEFT OUTER JOIN node n ON fu.id = n.nid
  WHERE fu.type = 'node' AND n.nid IS NULL
```

To find orphans in code:

```php
$fids = \Drupal::database()->query(
  "SELECT fm.fid FROM {file_managed} fm
     LEFT OUTER JOIN {file_usage} fu ON fm.fid = fu.fid
     LEFT OUTER JOIN {node} n ON fu.id = n.nid
   WHERE fu.type = :t AND n.nid IS NULL", [':t' => 'node']
)->fetchCol();
```

## Unmanaged-files entity

`unmanaged_files` content entity (`src/Entity/UnmanagedFiles.php`): base table
`unmanaged_files`, id key `unfid`, label `path`; fields `path` (string) + `created`.
Represents a file found on disk but absent from `file_managed`.
