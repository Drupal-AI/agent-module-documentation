<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush — delete files by FID

One command, defined in `src/Commands/FancyFileDeleteCommands.php` (registered via
`drush.services.yml`, service `fancy_file_delete.commands`).

## `fancy:file-delete`

- **Aliases:** `ffd`, `fancy-file-delete`
- **Argument:** `file_list` — a single FID or a **comma-separated** list of FIDs
  (e.g. `12` or `12,15,20`). Omitting it errors out.
- **Option:** `--force` — force-remove the file even if it is still referenced in
  `file_usage` (same semantics as the FORCE VBO action / Manual checkbox).
- **Confirmation:** prompts *"WARNING! Are you sure you want to delete these files?"*.
  Pass Drush's global `-y`/`--yes` to auto-confirm in scripts.

```bash
# Delete one managed file by FID (interactive confirm)
drush fancy:file-delete 12

# Same, via alias, several FIDs, non-interactive
drush ffd 12,15,20 -y

# Force-delete a stuck/orphaned file (drops file_managed + file_usage rows)
drush ffd 12 --force -y
```

## Behaviour notes

- The command explodes the list and hands the FIDs + force flag to the
  `fancy_file_delete.batch` service (`setBatch($values, $force, FALSE)`), which runs a
  non-progressive Drush batch (`drush_backend_batch_process()`); it prints
  "`N files cleansed.`" on success.
- Each value is processed by `FancyFileDeleteBatch::process()`. **Numeric** values are
  treated as FIDs (managed-file delete / force delete). A **non-numeric** value is treated
  as a filesystem *path* and deleted as an unmanaged file — so only pass numeric FIDs here
  unless you intend the unmanaged-path behaviour.
- Force delete = delete `file_managed` row + `file_usage` row(s) + the file entity. Normal
  delete uses `File::delete()` and is skipped for still-referenced files.
