<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush dialog (drush_dialog) — agent index

An in-page overlay that runs **Drush commands from the browser**. A user with the core
**`administer site configuration`** permission presses **Ctrl+D**, types a Drush command, and
the module runs `drush <command>` on the server (Symfony `Process`) and prints the output back
into the overlay. Every command + output is stored per user in the `drush_dialog_log` DB table
and drives an up/down-arrow history. Version **1.0.1**. Core `^9.2 || ^10 || ^11`. License
GPL-2.0-or-later. Package: none declared.

- **Controller, routes, JS behavior, library attach** → [api/controller.md](api/controller.md)
- **Log repository + `drush_dialog_log` schema (install hook)** → [api/log-repository.md](api/log-repository.md)

## What it actually is (from source)

- **No dependencies** beyond core; no `composer.json`, no submodules, no config, no
  `*.permissions.yml` (it reuses core's `administer site configuration`), no Drush commands of
  its own, no plugin types.
- **Two routes** (`drush_dialog.routing.yml`), both gated by `_permission: administer site
  configuration`:
  - `drush_dialog.run` — `/drush-dialog/run/{command}` → `DrushDialogController::run()`.
  - `drush_dialog.commands_list` — `/drush-dialog/commands-list` → `commandsList()`.
- **One service** (`drush_dialog.services.yml`): `drush_dialog.repository` =
  `DrushDialogLogRepository`, args `@database`, `@logger.channel.default`.
- **One DB table** `drush_dialog_log` (`drush_dialog_schema()` in `.install`): `id`, `uid`,
  `created`, `command` (varchar 255), `output` (big text), index on `uid`.
- **Hooks** (`drush_dialog.module`): `hook_page_attachments()` attaches the
  `drush_dialog/drupal.drush_dialog` library on every page **only** for users with `administer
  site configuration`. (There is also a mis-named `drush_dialog_test_help()` that is never
  invoked as a real `hook_help` — the function name is wrong.)
- **Front end**: library `drupal.drush_dialog` (`drush_dialog.libraries.yml`) = `js/drush_dialog.js`
  + `css/drush_dialog.css`, deps core/jquery, core/drupal, core/drupalSettings, core/once,
  core/drupal.autocomplete. The JS binds Ctrl+D/Ctrl+K to open the overlay, sends the typed
  command to `/drush-dialog/run/<command>` via AJAX, and loads history from
  `/drush-dialog/commands-list`.

## Mechanism

- `run(string $command)` (`DrushDialogController.php`): `explode(' ', $command)`,
  `array_unshift($params, 'drush')`, `new Process($params)`, `run()`; returns
  `$process->getOutput()` on success else `getErrorOutput()`, as a `JsonResponse`. Calls
  `saveDrushLog()` → `repository->insert(['uid','created','command','output'])`.
- `commandsList()`: returns `repository->load(currentUser()->id())` — this user's last 100
  command strings, newest first — as JSON.
- `DrushDialogLogRepository` (`src/DrushDialogLogRepository.php`): `insert()` uses the DB API
  `insert()->fields()`; `load(int $uid)` uses `select()->condition('uid',$uid)->orderBy('created','DESC')->range(0,100)->fields(...,['command'])->fetchCol()`. Both parameterized.

## Requirements / operating notes

- Requires the **`drush` binary** to be resolvable and executable by the web server user
  (`Process(['drush', ...])` relies on PATH); on many hosts the web user cannot run Drush, so
  the dialog will return error output.
- Commands are **space-split** into process arguments and the route `{command}` is a single URL
  path segment (no literal `/`; use `%20` for spaces), so multi-word commands and commands with
  slashes have limited support.
