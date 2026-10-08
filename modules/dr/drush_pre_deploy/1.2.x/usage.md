<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
drush_pre_deploy adds "pre-deploy" hooks to Drush: functions named `MODULE_predeploy_NAME(&$sandbox)` in a `MODULE.predeploy.php` file that run at the very *start* of `drush deploy`, before `updatedb` and `config:import` — the mirror image of core's `hook_deploy_NAME()`.

---

Drush's `drush deploy` runs a fixed sequence — `updatedb --no-cache-clear`, `cache:rebuild`, `config:import`, `cache:rebuild`, `deploy:hook` — and `deploy:hook` fires `hook_deploy_NAME()` functions at the very *end*. What core gives you no slot for is code that must run *before* any of that, and there is a real class of work that belongs there: deleting a config object that would otherwise make `config:import` fail, fixing data a schema update is about to choke on, disabling a module whose update hook is known to break, or snapshotting the pre-update state so a migration can be verified afterwards. This module adds that slot. A pre-deploy hook is a function `MODULE_predeploy_NAME(array &$sandbox): ?string` in a `MODULE.predeploy.php` file (a theme's `THEME.predeploy.php` works too), taking the same batch-style `$sandbox` signature as deploy/post_update hooks and optionally returning a translated message. The module ships two Drush commands: **`deploy:pre-hook-status`** lists pending pre-deploy hooks (module, hook, description), and **`deploy:pre-hook`** prints that list, asks for confirmation, then runs each pending hook once — looping while `$sandbox['#finished'] < 1` for batchable work and honouring `--simulate`. It reuses core's `UpdateRegistry` (updateType `predeploy`) with a keyvalue store named `pre_deploy_hook`, so like deploy hooks each one runs exactly **once per environment** and is tracked there; `drush deploy:mark-complete` also marks all pending pre-deploy hooks complete. To wire it into a real deploy automatically, an optional "global" command file (`src/global/`) hooks `pre-command deploy` and re-dispatches `deploy:pre-hook` at the start of every `drush deploy` — but that file is only discovered if you add a project-root `drush/drush.yml` with `drush: include: - ${env.PWD}/web/modules/contrib/drush_pre_deploy/src/global`; without it, run `drush deploy:pre-hook` manually before `drush deploy`. Two cautions apply to every pre-deploy hook: it runs against the **old schema** (never assume anything the pending update introduces), and like all deployment hooks it runs once and is hard to test, so rehearse against a copy of production data. Version 1.2.1, core `^8`–`^11`, needs Drush ≥ 10.3.0, no dependencies, no permissions, no web surface — a pure CLI/developer tool.

---

- Run arbitrary code at the very start of `drush deploy`, before `updatedb` and `config:import`.
- Delete a stale config object so the subsequent `config:import` does not fail.
- Fix or clean up data that a pending `hook_update_N()` schema change would choke on.
- Disable a module whose update hook is known to break before updates run.
- Snapshot or measure the pre-update state so a migration can be verified afterwards.
- Rename or migrate content ahead of a field-storage change.
- Record deployment metrics or a marker before the release proceeds.
- Guard a deployment with a precondition that aborts early if unmet (throw an exception).
- List pending pre-deploy work with `drush deploy:pre-hook-status` before a release.
- Run pending pre-deploy hooks manually with `drush deploy:pre-hook`.
- Preview pre-deploy hooks without side effects using `drush deploy:pre-hook --simulate`.
- Author a batchable pre-deploy hook that processes records in chunks via `$sandbox['#finished']`.
- Return a translated status message from a hook to surface it in deploy output.
- Keep a pre-deploy step in a theme via `THEME.predeploy.php` (not only modules).
- Automatically inject pre-deploy hooks into `drush deploy` via a project `drush/drush.yml` include.
- Ensure a one-off deployment fix runs exactly once per environment (tracked in keyvalue).
- Mark all pre-deploy hooks as already run with `drush deploy:mark-complete` (e.g. on a fresh install).
- Replace an ad-hoc shell wrapper around `drush deploy` with in-codebase, reviewable hooks.
- Coordinate a complex multi-module release where some work must precede updates.
- Keep deployment logic versioned in the module whose change it supports, not in CI scripts.
