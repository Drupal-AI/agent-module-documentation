<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DrushDialogController, routes & front end

`src/Controller/DrushDialogController.php` (extends `ControllerBase`), wired by
`drush_dialog.routing.yml` and driven by `js/drush_dialog.js`.

## Routes (`drush_dialog.routing.yml`)

Both require `_permission: 'administer site configuration'` (core permission; the module defines
none of its own).

| Route id | Path | Controller method |
|---|---|---|
| `drush_dialog.run` | `/drush-dialog/run/{command}` | `DrushDialogController::run()` |
| `drush_dialog.commands_list` | `/drush-dialog/commands-list` | `DrushDialogController::commandsList()` |

Neither declares `methods:` or `_csrf_token`, so both answer GET.

## `run(string $command): JsonResponse`

1. `$params = explode(' ', $command);` then `array_unshift($params, 'drush');` → e.g.
   `['drush', 'cache:rebuild']`. `{command}` is a single path segment, so spaces come in as
   `%20` and become separate process arguments; a literal `/` is not routable.
2. `$process = new Process($params); $process->enableOutput(); $process->run();` — Symfony
   `Process` is given an **argument array** (no shell string), and runs the `drush` binary from
   the web server user's PATH.
3. Output = `$process->getOutput()` when `isSuccessful()`, else `$process->getErrorOutput()`.
4. `saveDrushLog($command, $output)` → `repository->insert(['uid' => currentUser()->id(),
   'created' => time(), 'command' => $command, 'output' => $output])`.
5. Returns `new JsonResponse($output)` (a JSON-encoded string).

## `commandsList(): JsonResponse`

Returns `repository->load($this->currentUser()->id())` — this user's last 100 `command` strings,
newest-first — as JSON. Used to populate the arrow-key history.

## Constructor / DI

`create()` injects `drush_dialog.repository` (`DrushDialogLogRepository`); stored as
`$this->repository`.

## Front end (`drush_dialog.module` + `js/drush_dialog.js` + library)

- `drush_dialog_page_attachments()` attaches library `drush_dialog/drupal.drush_dialog` on every
  page **only** if `currentUser()->hasPermission('administer site configuration')`.
- Library `drupal.drush_dialog` (`drush_dialog.libraries.yml`): `js/drush_dialog.js`,
  `css/drush_dialog.css`; deps `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`,
  `core/drupal.autocomplete`.
- `Drupal.behaviors.drush_dialog`: builds a hidden overlay form with a single text input.
  **Ctrl+D** (keyCode 68/206) or **Ctrl+K** (75) opens it and calls `commands_list_load()`;
  **Esc** (27) or Ctrl+D closes it. On **Enter** (13) it AJAX-GETs
  `Drupal.url('drush-dialog/run/' + $command)`, then appends the returned string into a `<pre>`
  in the results area; up/down arrows step through `commandsList`.
- Note: the module file also defines `drush_dialog_test_help()`, whose name does not match the
  `hook_help` naming convention, so no help text is actually registered.
