<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clean Files Entity (clean_files_entity) — agent index

A **cron/Drush file-deletion** maintenance tool. No admin UI, no route, no permission, no form —
it is configured entirely from `settings.php` and triggered by cron or `drush`. Version **2.0.0**,
package `Media`, core `^10 || ^11`, GPL-2.0-or-later.

## What it actually does

Every cron run (and `drush clean_files_entity:run`, which just calls the cron hook) executes two
independent deletion passes, each limited to `max` files per run (`$config['clean_files_entity']['max']`,
default **50**):

1. **Folder pass** — `CleanFilesEntity::runFolder()`. Runs **only if**
   `$config['clean_files_entity']['folders']` is set. Selects rows from **`file_managed`** whose
   `uri` starts with a configured prefix (`LIKE 'prefix%'`, prefix wildcards escaped) that have **no**
   row in **`file_usage`** (left join, `u.fid IS NULL`) → managed files under the folder with zero
   recorded usage. Deletes them.
2. **Node pass** — `CleanFilesEntity::run('node')`. **Always** runs. Selects `fid`s from
   **`file_usage`** where `type = 'node'` and the referenced `id` has no matching `nid` in
   **`node_field_data`** (left join `n.nid IS NULL`) → file-usage records pointing at a deleted node.
   Deletes those files.

`delete($fids)` removes **all** `file_usage` rows for each `fid`, loads each file entity via storage
and calls `$file->delete()` (drops the physical file + managed record), then logs the deleted URIs to
the `clean_files_entity` logger channel.

## Key source

- `clean_files_entity.module` — `clean_files_entity_cron()` wires both passes.
- `src/CleanFilesEntity.php` — the query + delete logic (`run`, `runFolder`, `delete`).
- `src/Drush/Commands/CleanFilesEntityCommands.php` — `clean_files_entity:run` (calls the cron hook).
- `README.md` — the `settings.php` config example.

## Configuration (settings.php only)

```php
$config['clean_files_entity'] = [
  'folders' => ['public://node_images/'],
  'max' => 100,
];
```

There is **no** config entity, **no** config schema, and **no** configure route. `folders` unset →
only the node pass runs. See `agent/config/settings.md`.

## Cautions (this permanently deletes files)

- The selection is cruder than "unused": a file referenced only from **body-field HTML**,
  **configuration**, a **custom table**, or an **external URL** has no `file_usage` row and the folder
  pass will delete it if it sits under a configured folder.
- `delete()` wipes **every** usage row for a matched `fid`, including still-valid ones.
- No dry-run, no confirmation, no undo. Back up first; scope `folders` narrowly; read the log.
