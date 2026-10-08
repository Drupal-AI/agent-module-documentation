<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clean Files Entity is a cron/Drush maintenance tool that deletes file entities Drupal considers unused: managed files under configured folder prefixes that have zero `file_usage` rows, and files whose `file_usage` record of type `node` points at a node that no longer exists. There is no admin UI — it is configured entirely from `settings.php`.

---

The module runs on every cron (and on demand via `drush clean_files_entity:run`) and performs two independent deletion passes, each capped at `max` files per run (default **50**, overridable in `settings.php`). The **folder pass** runs only when `$config['clean_files_entity']['folders']` is set: for each configured URI prefix (e.g. `public://node_images/`) it selects rows from `file_managed` whose `uri` starts with that prefix (`LIKE 'prefix%'`, wildcards in the prefix are escaped) that have **no** matching row in the `file_usage` table, and deletes them. The **node pass** always runs: it selects `fid`s from `file_usage` where `type = 'node'` and the referenced `id` has no matching `nid` in `node_field_data` — i.e. file-usage records left behind after a node was deleted — and deletes those files. Deletion (`delete()`) removes **all** `file_usage` rows for each selected `fid`, then loads and deletes each file entity (removing both the physical file and its managed record) and logs the deleted URIs to the `clean_files_entity` channel. **This permanently deletes data, and the two selection criteria are cruder than "unused" implies.** The folder pass treats *any* zero-`file_usage` file under a folder as deletable, but many genuinely-referenced files carry no `file_usage` row at all — files linked from body-field HTML, referenced in configuration, pointed at by a custom table, or linked externally by URL — so pointing it at a folder that holds such files deletes them. The node pass keys only on node usage, yet its delete step wipes *every* usage row for a matched file, so a file that has both a stale node-usage row and a still-valid reference is removed with its live references. There is no reporting/dry-run mode, no confirmation, and no restore; the correct operating posture is a full backup first, a narrow folder scope, and reading the log after each run. Version **2.0.0**, core `^10 || ^11`, Media package, GPL-2.0-or-later.

---

- Delete managed files under a specific folder that have no recorded file usage.
- Reclaim disk space taken by orphaned uploads on a long-lived site.
- Clean up files left behind after nodes were deleted (stale `file_usage` rows).
- Purge generated image derivatives collected under a dedicated directory.
- Automate file pruning on cron with no admin interaction.
- Trigger a cleanup pass on demand with `drush clean_files_entity:run`.
- Cap deletions per run with the `max` setting to bound cron load.
- Reduce backup size by removing unreferenced files from the files directory.
- Speed up environment syncs on media-heavy sites.
- Scope cleanup to `public://node_images/` (the documented example folder).
- Clean up after bulk node deletion left orphaned file-usage records.
- Keep a scratch/import directory free of files nothing references.
- Log the URIs of every deleted file for later audit via the watchdog channel.
- Run the same logic from cron and from CLI (the Drush command just calls the cron hook).
- Restrict cleanup to configured URI prefixes so unrelated files are untouched.
- Prune temporary import folders after a migration.
- Remove leftover files in a folder used only by a decommissioned feature.
- Bound each run to a safe batch size before scaling folder scope up.
- Establish a recurring storage-hygiene job on a maintenance schedule.
- Delete only files matching a folder prefix rather than the whole filesystem.
