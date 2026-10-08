<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Backup exports the site's active configuration to a timestamped `.tar.gz` archive on disk.

---

Config Backup (`config_backup`) adds a one-click way to **snapshot the active configuration** — the
same data as `drush config:export` — into a single gzipped tar archive named
`configs-<Ymd_His>.tar.gz`. You trigger a backup from an admin form at
`/admin/config/development/configuration/backup` (a task under core's Configuration → Synchronize)
or from the command line with `drush config:backup` (alias `cbkp`). The destination is a directory
you set in `settings.php` via `$settings['config_backup_directory']`; there is no default, and the
README suggests a path outside the webroot (and adding it to `.gitignore`). The module depends only
on core's Configuration Manager (`config`) and gates the UI behind its own `backup configuration`
permission. It creates archives only — restoring a snapshot is a manual operation (extract into a
config sync directory and run `drush config:import`); the module itself does not download, list,
restore, or delete backups.

---

- Grab a safety snapshot of configuration before a risky change or deployment.
- Create a config archive from the admin UI with a single **Backup** button.
- Create a config archive from the CLI with `drush config:backup`.
- Use the `cbkp` Drush alias for shorter commands.
- Script or schedule backups (e.g. cron/CI) using the Drush command.
- Snapshot the active configuration (equivalent to `drush config:export` contents).
- Produce a portable, timestamped `.tar.gz` you can archive or move off-site.
- Keep a series of point-in-time config snapshots by re-running the backup.
- Choose the backup destination directory via `$settings['config_backup_directory']` in settings.php.
- Store backups outside the webroot, as the README recommends.
- Restrict who can create backups with the `backup configuration` permission.
- Add the Backup tab under Configuration → Synchronize for admins.
- Capture all config collections (not just the default) in one archive.
- Verify the target directory is writable before backing up (the form warns if it is not).
- Include the archive path in output/logs (`Saved to <file>.`) for automation.
- Pair with `config_split` / `config_ignore` workflows to keep a raw export snapshot.
- Take a pre-migration or pre-upgrade configuration snapshot.
- Keep a manual restore point separate from your Git-tracked config sync directory.
- Move a config snapshot between environments manually (extract + `drush config:import`).
- Audit or diff a past snapshot by extracting the archive and comparing YAML files yourself.
