<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Console: run PHP & SQL (`/admin/console`)

`DeveloperConsoleForm` (`src/Form/DeveloperConsoleForm.php`, form id `dev_console_form`) is the main tool. `DeveloperConsoleSandboxForm` (`/admin/console/form`, id `developer_console_sandbox`) is a throwaway scratch form whose `validateForm`/`submitForm` just call `kdpm()` to dump submitted values.

## Install & access
- Enable: `drush en developer_console`. Ensure `kint-php/kint:>=5.0` is present via Composer (it is required in the module's `composer.json`).
- Reach the console: grant the `access console` permission (declared `restrict access: TRUE`). Both routes (`developer_console.console`, `developer_console.sandbox_form`) require it and are `_admin_route: TRUE`. There is no settings/config form (`configure` is null).
- This is a development/staging tool: the console evaluates whatever code or SQL is submitted, in the current request, as the web user. Grant the permission only to trusted developers and keep it off production.

## Console form fields (`buildForm`)
- `input_type` — radios, `PHP` (default) or `SQL`.
- `input` — textarea (20 rows) for the code/query. Required (`validateForm` errors if empty).
- `save_entry` — checkbox (default on): whether to store the entry in history.
- `execute` — submit button.
- A "Results" fieldset (rebuilt into form storage) shows execution time and, depending on mode, returned/printed output.
- A history block lists prior inputs; `js/developer_console.js` shows only the history for the selected type and lets you click an entry (`.console-history-selector`) to copy it back into `#edit-input`.

## Execution model (`submitForm`)
Constructor injects `renderer` and `database`. `submitForm` calls `$form_state->setRebuild()` then branches on `input_type`:
- **PHP**: sets `ini_set('display_errors','stderr')`, starts an output buffer, records `microtime`, and runs `$this->eval($input)` — a thin wrapper `protected function eval($code) { return eval($code); }` (isolates caller locals). `\ParseError` and `\Exception` are caught and surfaced via `messenger()->addError(...)` (exception traces are additionally dumped with `kdpm()`). Buffered output becomes `results['print']`; the eval return value is captured but only rendered when present.
- **SQL**: runs the query through `$this->connection->prepareStatement($input, $options, TRUE)` then `$result->execute([], $options)` with options `fetch => PDO::FETCH_OBJ`, `allow_delimiter_in_query => FALSE`, `allow_square_brackets => FALSE`, `debug => TRUE`. On success it iterates rows into a themed `#theme => 'table'` (`table()` helper via `renderer->render()`), reports affected rows via `rowCount()` (guards `RowCountException`), and shows the table. Errors are dumped with `kdpm($e, 'SA')`.
- Execution time = `round((end-start)*1000, 3)` ms, shown in the Results fieldset.

## History (`developer_console_history` table)
Schema from `developer_console.install` (`hook_schema`): `hid` (serial pk), `type` (varchar 10), `input` (text), index on `type`. When `save_entry` is on, `submitForm` caps each `type` at 10 rows (deletes oldest `hid` while count ≥ 10) and skips saving if the newest entry equals the current input. History is read back in `buildForm` (ordered `hid DESC`) and rendered into the form.

## Notes for agents
- There is no API to call the console programmatically; it is a UI form. To script equivalent behaviour use Drush `php:eval` / `php:script` or a direct `\Drupal::database()` query instead.
- Nothing here is anonymous: every entry point is behind the restricted `access console` permission on an admin route.
