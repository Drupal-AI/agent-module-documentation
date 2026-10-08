<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Texts — Drush commands

Defined in `src/Drush/Commands/TextsCommands.php` (service `texts.drush_commands`). Both exist to manage duplicate `texts` rows that violate the `(key, context, langcode)` unique key — historically these could arise before the constraint was added, and `texts_update_10001` refuses to apply the unique index until duplicates are cleared.

## `texts:cleanup-duplicates` (alias `texts-cleanup`)

Finds groups of rows sharing the same `key` + `context` + `langcode` (ignoring keys that already contain `__duplicate_`), keeps the lowest `id`, and renames the rest to `{key}__duplicate_{id}`. The renamed rows can later be restored to the original key from the admin overview (the "Restore to original key" operation → `TextsController::restoreDuplicate`).

- `--dry-run` — report the duplicate groups and how many rows would be renamed, without changing anything.

Run this first if `drush updb` fails on the unique-index update.

## `texts:delete-duplicates` (alias `texts-delete-dups`)

Permanently deletes every entity whose `key` matches `%__duplicate_%` (i.e. the backups left by cleanup).

- `--dry-run` — count and preview the entities that would be deleted (first 5 shown), without deleting.

Typical sequence: `drush texts:cleanup-duplicates` → verify → `drush updb` → later `drush texts:delete-duplicates` once you no longer need the backups.
