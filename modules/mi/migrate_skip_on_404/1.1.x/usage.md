<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate: Skip On 404 provides a `skip_on_404` migrate process plugin that skips a file (or the whole row) when the source file does not exist, so a missing file no longer aborts the migration; it also auto-injects that plugin into core's Drupal-7 file migrations.

---

The module adds one migrate process plugin, `skip_on_404` (class `SkipOn404`, extends `ProcessPluginBase`), which checks whether the incoming file reference actually exists before the pipeline continues. For external URLs it issues a Guzzle `HEAD` request via the `http_client` service and treats a `RequestException` as "missing"; for local paths it uses PHP `file_exists()`. It supports both usual process-plugin methods: `method: row` throws a `MigrateSkipRowException` (skipping the entire record and logging a message in the migration's message table) while `method: process` calls `stopPipeline()` to halt only the current property. Beyond the reusable plugin, the module implements `hook_migration_plugins_alter()` to automatically splice `skip_on_404` into the `source_full_path` process chain of the standard D7 file migrations (`d7_file`, `d7_file_private`, and their Migrate Upgrade equivalents `upgrade_d7_file` / `upgrade_d7_file_private`), so upgrades tolerate missing public and private files with no configuration at all. It has no settings, routes, permissions, config schema, or Drush commands — enabling it is the entire setup for the automatic behaviour, and the plugin is available to any custom migration by name.

---

- Keep a Drupal 6/7 → Drupal 10/11 upgrade running when some source files are missing instead of failing the whole file migration.
- Skip rows for public files that no longer exist on the legacy server during `d7_file`.
- Skip rows for private files that are gone during `d7_file_private`.
- Tolerate missing files transparently when running the Migrate Drupal UI upgrade.
- Tolerate missing files when running Migrate Upgrade's `upgrade_d7_file` / `upgrade_d7_file_private` via Drush.
- Add `skip_on_404` to a custom file migration so absent files are skipped, not fatal.
- Choose `method: row` to drop the entire record when a referenced file is missing.
- Choose `method: process` to stop only the file property while keeping the rest of the row.
- Leave a diagnostic message ("404 - … does not exist") in the migration message table for each skipped file, so missing files are easy to audit afterwards.
- Guard a remote-URL file source by issuing a lightweight HEAD request before download.
- Guard a local filesystem file source with an existence check before `file_copy`.
- Migrate a media library where a percentage of assets are known to be missing without manual pre-filtering.
- Run repeatable, resumable migrations that don't stop on the first bad file.
- Combine with `file_copy`/`download` process plugins to protect the copy step.
- Pre-validate an image field's source path in a custom node migration.
- Skip documents referenced by a legacy CSV whose files were never delivered.
- Avoid writing custom PHP just to test file existence inside a migration pipeline.
- Continue a large batch migration overnight without babysitting missing-file failures.
- Feed cleaner data downstream because rows with missing files never create broken file entities.
- Audit which legacy files were absent by reviewing the logged skip messages.
- Use the plugin standalone in a `migrate_plus` migration config entity by referencing `plugin: skip_on_404`.
- Protect both public and private file streams in one upgrade because both core migrations are patched automatically.
- Enable the module right before an upgrade run and disable it after, with no config to clean up.
- Reduce migration-run error noise so genuine failures stand out.
