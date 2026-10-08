<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drush-pre-deploy (drush_pre_deploy) — agent index

Adds **"pre-deploy" hooks** to Drush — functions that run at the very *start* of `drush deploy`,
before `updatedb` and `config:import`, mirroring core's end-of-deploy `hook_deploy_NAME()`.
Version **1.2.1**. Core `^8 || ^9 || ^10 || ^11`. Needs **Drush ≥ 10.3.0**. No dependencies, no
permissions, no config, no web routes — a CLI/developer tool only.

## Mechanism (from source)

- **The hook.** A pre-deploy hook is a function `MODULE_predeploy_NAME(array &$sandbox): ?string`
  placed in a `MODULE.predeploy.php` file (themes: `THEME.predeploy.php`). Note the token is
  `predeploy` (one word) and the file extension is `.predeploy.php`. See `drush_pre_deploy.api.php`
  for the documented signature (`hook_predeploy_NAME`). It may return an optional translated
  message and should throw `\Exception` on error.
- **Discovery/tracking.** `src/Commands/DrushPreDeployCommands.php` builds an anonymous subclass of
  core `\Drupal\Core\Update\UpdateRegistry` with **updateType `predeploy`** and a keyvalue store
  collection **`pre_deploy_hook`**. This reuses core's own deploy/post_update discovery: it scans
  the enabled modules and themes for `*.predeploy.php` and their `_predeploy_` functions, and records
  which have run — so each hook runs **once per environment**.
- **Commands** (registered via `drush.services.yml`, service `drush_pre_deploy.commands`, args
  `%app.root%`, `%site.path%`, `@module_handler`, `@keyvalue`, `@theme_handler`):
  - `deploy:pre-hook-status` — prints pending pre-deploy hooks (fields: module, hook, description).
  - `deploy:pre-hook` — prints the pending list, prompts for confirmation, then runs each pending
    hook, looping while `$sandbox['#finished'] < 1`; honours `--simulate`; returns 0/1.
  - `markComplete` — `@hook pre-command deploy:mark-complete`: marks all pending pre-deploy hooks
    complete when `drush deploy:mark-complete` runs (no standalone command of its own).
- **Auto-injection into `drush deploy`.** `src/global/DrushPreDeployHookCommands.php` is a "global"
  Drush command with `@hook pre-command deploy`; when `drush deploy` starts it re-dispatches
  `deploy:pre-hook` as a subprocess **before** `updatedb`. This file is **not** autoloaded — it is
  only discovered if a project-root `drush/drush.yml` includes it (see `drush/config.md`). Without
  that include, run `drush deploy:pre-hook` manually before `drush deploy`.

## Where it fits in `drush deploy`

Core sequence: `updatedb` → `cache:rebuild` → `config:import` → `cache:rebuild` → `deploy:hook`.
With the global include, the effective start becomes `deploy:pre-hook` → (the above). The slot this
module fills is the one core lacks: work that must happen **before** updates and config import —
deleting config that would block `config:import`, fixing data a schema update would choke on,
disabling a module whose update hook breaks, or snapshotting pre-update state for later verification.

## Two cautions for every pre-deploy hook

1. **It runs before updates** — against the **old schema**. Never assume anything the pending update
   introduces. This is the commonest way a pre-deploy hook breaks a deployment.
2. **Deployment hooks run once per environment and are hard to test.** The first real run is on
   production unless rehearsed against a copy of production data — the only rehearsal that counts.

## Map

- `drush/commands.md` — the two Drush commands, flags, run/confirm/batch behaviour, mark-complete.
- `drush/config.md` — the `drush/drush.yml` include that auto-injects pre-deploy into `drush deploy`.
- `hooks/authoring.md` — how to write a `MODULE.predeploy.php` hook (signature, `$sandbox`, messages).
- Security: CLI-only, runs developer-authored PHP; no web route, no untrusted input. `SECURITY: clean`.
