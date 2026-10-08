<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DevUtils Drush commands

Source: `src/Commands/DevutilsCommands.php` (registered as `devutils.commands` with tag `drush.command` in `drush.services.yml`; constructor args `@entity_type.manager`, `@file.usage`). Enable with `drush en devutils`.

## devutils:uuid

Signature: `public function devutils(string $entityType = 'node', string $filter = 'all', array $options = ['label' => FALSE])`.

- `@command devutils:uuid`, `@aliases devuuid`, `@option label`.
- Prints one line per entity: `- <uuid>`. With `--label`, each entity is preceded by `# <label>`.
- `$entityType` selects the storage via a `switch`; supported types and how `$filter` (default `all`) is applied:
  - `node` — `all` loads all; otherwise `loadByProperties(['type' => $filter])`.
  - `media` — `all` uses `loadMultiple()`; otherwise `loadByProperties(['bundle' => $filter])`.
  - `term` — storage `taxonomy_term`; `all` uses `loadMultiple()`; otherwise `loadByProperties(['vid' => $filter])`.
  - `block` — storage `block_content`; `all` → `loadByProperties()`; otherwise `['type' => $filter]`.
  - `menu_link` — storage `menu_link_content`; `all` → `loadByProperties()`; otherwise `['menu_name' => $filter]`.
  - `paragraph` — `all` → `loadMultiple()`; otherwise `['type' => $filter]`.
  - `file` — always `loadMultiple()` (filter ignored).
- An unlisted `$entityType` yields no entities (empty output).

Examples:
```shell
drush devutils:uuid node
drush devutils:uuid node page --label
drush devutils:uuid media image
drush devutils:uuid term tags
drush devutils:uuid file
```

## devutils:clear-files

Signature: `public function clearFiles()`. `@command devutils:clear-files`, `@aliases devutils clear-files`.

- Loads every `file` entity (`getStorage('file')->loadByProperties()`).
- For each file, calls `$this->fileUsage->listUsage($file)` (the `file.usage` / `DatabaseFileUsageBackend` service). If the usage list count is `0`, calls `$file->delete()` and prints `Delete file:<label>`.
- Destructive and irreversible: it removes managed files that Drupal records no usage for. Back up first; run only in a controlled/development environment. Files whose usage is tracked outside `file_usage` will still be deleted.

```shell
drush devutils:clear-files
```

Note: `src/Commands/DrushDevutilsCommands.php` defines an equivalent command class (aliases differ: `devutils uuid` / `devutils clear-files`) using Drush's `AutowireTrait` attribute style, but it is not wired in `drush.services.yml`; the `DevutilsCommands` class above is the one Drush loads.
