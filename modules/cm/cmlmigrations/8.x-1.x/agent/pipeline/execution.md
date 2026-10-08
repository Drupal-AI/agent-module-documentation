<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pipeline, execution & admin pages

Migrations run **out of process** — the module shells out to `drush mim --group=cml` rather than
running the Migrate executable in the request. Everything below the Drush layer is gated by
`administer site configuration` (the routes) or runs from cron/CLI.

## Services

- **`cmlmigrations.migrate`** (`MigrateService`) — `getCmlGroup()` lists the `cml`-group migrations
  with status/total/imported/messages (via `plugin.manager.migration`); `import()` is the long-poll
  loop that drives `PipeLine` until the cml queue empties (`sleep(3)` between passes).
- **`cmlmigrations.exec`** (`ExecService`) — builds and runs the drush command with **`shell_exec`**:
  - `exec($nohup, $update)` → `"{$drush} mim --group=cml --root=$root"` (+ `--update`, optionally
    wrapped in `nohup … > ~/cmlmigrations-nohup.log … &`).
  - `nohupRunMigrations()` → `nohup {$drush} cmlmigrations >> ~/cmlmigrations.log &`.
  - `execTest()`/`drushTest()`/`nohupTest()` → `whoami` / `drush --version` / `nohup --version`
    (environment probes surfaced on the status page).
  - `getDrush()` returns the `cmlmigrations.settings:drush` path or the `/var/www/html/vendor/bin/drush`
    default. **The drush path is interpolated into the shell string** — see the security note below.
- **`cmlmigrations.pipeline`** (`PipeLine`) — the `cml` entity state machine. `import($cml,$migrations)`:
  `new` + migrations idle → set `progress`, call `exec(TRUE,TRUE)`; `progress` → `success` when idle,
  else `failure` once `changed + timeout(min)` passes; a "too quick" guard returns `progress` to avoid
  a false `busy`. Writes `cmlapi.settings:runing_cml`.
- **`cmlmigrations.clear`** (`ClearService`) — cron watchdog: if `cml_migrate_current` /
  `cml_migrations` state is older than **3600s**, resets stuck migrations to Idle
  (`setStatus(0)`) and marks the cml `failure`.
- **`cmlmigrations.scheme`** (`Scheme`) — stub; all methods return empty (feature "not ready").

## Cron & Drush

- **`hook_cron`** (`Hook/Cron`) → `ClearService::clear()`, and if both clear checks pass,
  `MigrateService::import()` — so a plain cron run advances the exchange.
- **Drush `cmlmigrations`** (`CmlmigrationsCommands::cmlmigrationsRun`) — acquires the Drupal lock
  `cmlmigrations` (waits with 5s back-off if held), then runs `MigrateService::import()`, then
  releases. This is the command the nohup wrapper invokes.

## Admin pages

- **`cmlmigrations.status`** → `/cmlmigrations/status` (`Controller/StatusPage::page`). Renders raw
  `#markup` (Russian labels) of the actual/current/next/queued `cml` exchanges and their states, a
  ready/busy indicator, a status table of the cml migrations, and embeds the **`ExecMigrations`
  form**. Data shown is entity ids / states / timestamps, not free-text.
- **`ExecMigrations`** (`Form/ExecMigrations`, id `cmlmigrations_exec`) — AJAX buttons: Import /
  Import Nohup / Update / Update Nohup (→ `ExecService::exec`), Test Exec/Drush/Nohup, and an
  **Unpublish** panel (with a Confirm checkbox) that unpublishes all mapped products or catalog terms
  and blanks the migrate-map hashes so the next run re-imports them. All of it is only reachable with
  `administer site configuration`.
- **`cmlmigrations.scheme`** → `/cmlmigrations/scheme` (`Controller/SchemePage::page`) — currently a
  placeholder outputting `"hello world"` (scheme feature unfinished).

## Install / update hooks

`cmlmigrations.install` has only `cmlmigrations_update_8001()` (backfills `product`/`variation`
config defaults). The `product_uuid` base field requires `drush entity-updates` after enable/update
(see [migrations/sources.md](../migrations/sources.md)).

## Security note (operational)

`ExecService` runs `shell_exec()` on a command that includes the admin-configurable **`drush`** path
from `cmlmigrations.settings`. Reaching it requires the **`administer site configuration`** permission
(a trusted/privileged permission), so it is not an anonymous or low-privilege vector; treat that
permission as equivalent to server access. There are no public/unauthenticated endpoints in this
module, and it performs no XML parsing (delegated to `cmlapi`) and no remote fetches of its own.
