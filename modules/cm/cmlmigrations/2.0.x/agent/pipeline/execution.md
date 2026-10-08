<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pipeline, Exec, Clear, Cron, Drush, status & scheme pages

Services (`cmlmigrations.services.yml`): `cmlmigrations.migrate` (`Service/MigrateService`),
`.exec` (`Service/ExecService`), `.clear` (`Service/ClearService`), `.pipeline` (`Service/PipeLine`),
`.scheme` (`Service/Scheme`).

## Execution model

Migrations run **out of process**. `Service/ExecService`:
- `exec($nohup = TRUE, $update = FALSE)` builds `"{$drush} mim --group=cml --root=$root"` (adds
  `--update`, and when `$nohup` wraps it in `nohup … > ~/cmlmigrations-nohup.log … &`) and runs it
  with **`shell_exec`**.
- `getDrush()` returns the `drush` config value from `cmlmigrations.settings` or the default
  `/var/www/html/vendor/bin/drush`.
- `execTest()` / `drushTest()` / `nohupTest()` run `whoami`, `drush --version`, `nohup --version`
  for the status-page "Test Environment" buttons.

`Service/PipeLine::init()` picks the actual `cml` exchange (`cmlapi.cml->actual()`), and `import()`
implements the state machine: `new` → (migrations idle) set `progress` + `exec(TRUE, TRUE)`;
`progress` → `success` when migrations finish, or `failure` on timeout (`timeout` minutes from
config, default 3600 s). Uses `queryQuickRun()` / `query()` entity queries (all `accessCheck(TRUE)`)
against the `cml` storage. It records the running exchange id in `cmlapi.settings` `runing_cml`.

`Service/MigrateService`:
- `getCmlGroup()` enumerates migration plugins whose `migration_group === 'cml'` and reports
  status/total/imported/messages/last — `status = TRUE` means all Idle (ready to run).
- `import()` is the in-loop importer (called by the Drush command and cron): while there is a
  queued `cml`, run the pipeline, `sleep(3)`, repeat; writes progress to `state` keys
  `cml_migrations` / `cml_migrate_current`.

`Service/ClearService` (cron watchdog): `clearMigrations()` resets `cml_migrate_current` and sets the
stuck exchange to `failure` after 1 h (also resets each non-Idle migration's status to 0);
`clearCmlmigrations()` frees the `cml_migrations` process flag after 1 h.

`Hook/Cron` → `cmlmigrations.clear->clear()`; only if both flags are clear does it call
`cmlmigrations.migrate->import()`.

## Drush command

`Drush/Commands/CmlmigrationsCommands` registers `#[CLI\Command(name: 'cmlmigrations')]`. It acquires
the Drupal **lock** `cmlmigrations` (waiting/retrying if held), calls `MigrateService::import()`, then
releases the lock. `drush.services.yml` wires `@lock`, `@logger.channel.cmlmigrations`,
`@cmlmigrations.migrate`.

## Routes / pages (all `_permission: administer site configuration`)

- **`cmlmigrations.status`** → `/cmlmigrations/status` (`Controller/StatusPage::page`): renders the
  actual/current/next exchange and the queue (in Russian), the migration status table
  (`getCmlGroup()`), and embeds the **`Form/ExecMigrations`** form.
- **`cmlmigrations.scheme`** → `/cmlmigrations/scheme` (`Controller/SchemePage::page`): shows the
  current exchange id only (the `cml_scheme` feature is stubbed).
- **`cmlmigrations.settings`** → `/admin/structure/migrate/cmlmigrations` — see
  [../config/settings.md](../config/settings.md).

## ExecMigrations form (`Form/ExecMigrations`)

Buttons on the status page (AJAX):
- **Run**: Import / Import Nohup / Update / Update Nohup → `ExecService::exec()` variants.
- **Unpublish**: `ajaxUnpublish()` (behind a *Confirm* checkbox) unpublishes all imported products
  (`unpublishProducts()`) and/or catalog terms (`unpublishCatalog()`) via `migrate_map_*` destids,
  then blanks the map `hash` so a re-import re-processes them; `countProducts()` / `countCategories()`
  show the affected counts.
- **Test Environment**: Test Exec / Drush / Nohup.

All map/unpublish queries use the DB API with bound `IN` conditions and entity storage
(`accessCheck(FALSE)` is used only for these admin-gated bulk operations). No user-supplied value
enters the `shell_exec` command line — the only variable is the admin-set `drush` config path — and
the module makes no outbound network calls of its own.
