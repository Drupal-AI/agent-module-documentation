Migrate Tools adds the Drush commands and admin UI you actually use to run, monitor, and manage core migrations — running imports, rolling back, checking status, and reading migration messages.

---

Drupal core's Migrate API can define and execute migrations, but it ships no user-facing way to run them; Migrate Tools fills that gap. Its primary value is a set of Drush commands — `migrate:status`, `migrate:import`, `migrate:rollback`, `migrate:messages`, `migrate:stop`, `migrate:reset-status`, `migrate:disable`, `migrate:fields-source`, and `migrate:tree` — that drive migrations from the command line with fine-grained control over groups, tags, ID lists, limits, batch size, update, sync, and continue-on-failure behavior. When `migrate_plus` is installed it also provides an admin UI under **Structure → Migrations** (`/admin/structure/migrate`) for browsing migration groups and individual migrations, viewing their source/process/destination mappings, executing them, and reading logged messages. All of this is gated by a single `administer migrations` permission. It integrates its own batch executable and an event subscriber that renders progress bars during long CLI runs. It also defines a `migrate_shared_configuration` plugin type so modules can share common source/process configuration across many migrations via a `MODULE.migrate_shared_configuration.yml` include mechanism. It is the de-facto standard companion to core Migrate for any real content or site migration.

---

- Run a single migration from the CLI with `drush migrate:import <id>`.
- Import every migration in a group with `drush mim --group=<group>`.
- Import all migrations tagged a certain way with `--tag=<tag>`.
- Check the status (total/imported/unprocessed) of all migrations with `drush migrate:status`.
- Get a fast, names-only migration list with `drush ms --names-only`.
- Roll back an import with `drush migrate:rollback <id>` to undo destination records.
- Roll back an entire group of migrations at once.
- Re-import only specific rows using `--idlist=1,2,3`.
- Limit a test run to N items with `--limit=50`.
- Process large sources in chunks with `--batch-size`.
- Update previously-imported items with `--update` when source data changes.
- Sync source and destination with `--sync`, deleting destination records missing from source.
- Force a migration to run even when its dependencies are unmet with `--force`.
- Execute all dependent migrations first with `--execute-dependencies`.
- Keep a batch going past failures with `--continue-on-failure`.
- Reset a migration stuck in "Importing"/"Idle" limbo with `drush migrate:reset-status <id>`.
- Interrupt a long-running migration with `drush migrate:stop <id>`.
- Disable a misbehaving migration with `drush migrate:disable <id>`.
- Inspect logged errors for a migration with `drush migrate:messages <id>`.
- Discover available source fields for building process mappings with `drush migrate:fields-source <id>`.
- Visualize migration dependency ordering with `drush migrate:tree`.
- Browse migration groups and migrations in the admin UI at `/admin/structure/migrate`.
- View a migration's source, process, and destination configuration in the UI.
- Execute or roll back a migration from the browser via the Execute tab.
- Read per-row migration messages in the UI without touching the database.
- Show progress bars for long imports on the command line.
- Share common source/process settings across many migrations with a `migrate_shared_configuration` include.
- Gate all migration management behind the `administer migrations` permission for a migration-builder role.
- Script full site content migrations in CI/CD using the Drush commands.
