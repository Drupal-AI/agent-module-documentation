Backup and Migrate backs up and restores your Drupal database and files, and can move a site between environments, all from the admin UI, cron, or Drush.

---

Backup and Migrate lets you dump the Drupal database (and optionally the public/private files directories or the entire site) to a compressed archive, either on demand ("quick backup") or on a recurring schedule. Backups are produced from configurable **sources** (the default database, a MySQL database, the whole site, or a files directory) and written to configurable **destinations** (a server directory, private/public files, or download to the browser). It ships **Source** and **Destination** as config entities plus plugin types, so the set of things you can back up and where you can send them is extensible. A restore workflow reads a backup file back into the site, making it easy to roll back or clone content between staging and production. Schedules run under cron and can keep a rolling number of copies, deleting the oldest automatically. Optional filters compress (gzip/zip), name, and — with the `defuse/php-encryption` library — encrypt archives. Everything is permission-gated (perform backup, access backup files, restore, administer) and scriptable through Drush commands for CI and deployment pipelines.

---

- Take an on-demand "quick backup" of the database before a risky update.
- Schedule nightly database backups via cron.
- Back up the public and private files directories alongside the database.
- Back up the entire site (database + all files) in one archive.
- Restore the site's database from a previously saved backup file.
- Roll back after a bad deployment or content mistake.
- Clone production data down to a staging or local environment.
- Keep a rolling window of the last N backups and auto-delete older ones.
- Download a backup archive directly through the browser.
- Store backups in the private files directory so they aren't web-accessible.
- Store backups in a custom server directory destination.
- Compress backups with gzip or zip to save disk space.
- Encrypt saved backups using the optional php-encryption library.
- Exclude specific database tables (e.g. cache, sessions) from a dump.
- Run a scheduled backup from cron on a daily/weekly cadence.
- Trigger a quick backup from CI with `drush backup_migrate:quick_backup`.
- List configured sources, destinations, profiles and schedules via Drush.
- Fire all due scheduled backups in a deploy hook with `drush backup_migrate:schedule_backup`.
- Create reusable settings profiles for consistent backup options.
- Define a custom source plugin to back up an external data store.
- Define a custom destination plugin to push backups to remote storage.
- Grant editors download access to backups without giving restore rights.
- Restrict who can restore the site with a dedicated permission.
- Export backup configuration (sources/destinations/schedules) between environments as config.
- Produce a portable SQL dump for migrating a site to another host.
- Automate pre-release database snapshots in a pipeline.
