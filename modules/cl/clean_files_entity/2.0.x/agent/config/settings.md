<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — clean_files_entity

All configuration is a **settings.php global override**; there is no UI, no config entity, and no
config schema. The module reads two keys from `$GLOBALS['config']['clean_files_entity']`:

```php
// settings.php (or a per-environment settings include)
$config['clean_files_entity'] = [
  // URI prefixes for the folder pass. Optional. If unset/empty, the folder
  // pass is skipped and only the node pass runs on cron.
  'folders' => [
    'public://node_images/',
  ],
  // Max files deleted per pass, per cron/drush run. Optional; default 50.
  'max' => 100,
];
```

## Keys

- **`folders`** (array of URI prefixes) — read in `clean_files_entity_cron()`; each entry is used as a
  `LIKE 'prefix%'` match against `file_managed.uri` (prefix wildcards are escaped via `escapeLike`).
  Any managed file under one of these prefixes that has **no** `file_usage` row is deleted. Because it
  is a prefix, `public://node_images/` also matches `public://node_images_backup/…` — end the prefix
  with a trailing `/` to avoid sibling-folder bleed. If the key is unset or empty, the folder pass does
  not run.
- **`max`** (int, default `50`) — read in `CleanFilesEntity::__construct()`. Upper bound on the number
  of files each pass deletes per run (`range(0, max)`). Raise it to clear a backlog faster; lower it to
  bound the work cron does in one pass.

## Behaviour notes

- Both passes run on **every cron** and on `drush clean_files_entity:run`.
- The **node pass** (`run('node')`) has no configuration — it always runs and targets `file_usage`
  rows of type `node` whose node no longer exists.
- Deletions are logged to the `clean_files_entity` logger channel (URIs of deleted files). There is no
  reporting-only mode, so a first run against a new folder should use a small `max` and be reviewed in
  the log before widening scope.
- Since config comes from `settings.php`, it is developer/ops-controlled and cannot be changed by a web
  user — but that also means there is no in-site guardrail confirming the folder scope before deletion.
