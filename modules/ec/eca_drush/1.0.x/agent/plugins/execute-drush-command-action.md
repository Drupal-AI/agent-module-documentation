<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action: Execute Drush command

Source: `src/Plugin/Action/ExecuteDrushCommandAction.php`
Class: `ExecuteDrushCommandAction extends Drupal\eca\Plugin\Action\ConfigurableActionBase`

The module's only plugin. It is an ECA action, so it appears when building an ECA model
(add an action, pick "Execute Drush command"). It runs a single Drush command as a subprocess.

## Install / enable

- `composer require drupal/eca_drush` (pulls `drush/drush >= 13.0.0`), then enable `eca_drush`
  (requires `eca`). No config to install; nothing to configure globally.

## Annotation / identity

- `@Action(id = "eca_drush_simple_execute_drush_command", label = "Execute Drush command",
  description = "Runs a specific Drush command with the given arguments",
  eca_version_introduced = "2.1.4")`.

## Configuration keys (`defaultConfiguration()`)

- `command` (string, default `''`) — the Drush command name to run (e.g. `cache:rebuild`).
- `arguments` (string, default `''`) — free-text arguments/options appended to the command.
- Plus keys inherited from `ConfigurableActionBase::defaultConfiguration()`.

## Access — `access()`

- Overrides access to return `AccessResult::allowed()` unconditionally (returns bool or the
  result object per `$return_as_object`). The effective gate is therefore ECA model authoring
  and the event that fires the action, not a per-run permission check.

## Config form — `buildConfigurationForm()`

- Resolves the Drush binary via `getDrushExecutablePath()`. If not found, renders an error
  markup element and a disabled `arguments` textfield, then returns.
- Otherwise runs `[$drush_path, 'list', '--format=json']` with Symfony `Process` from
  `DRUPAL_ROOT` and `Json::decode()`s the output. On process failure or unparseable/`commands`-
  less output, it renders an error and a disabled `arguments` field.
- Builds a `command` select (`#type => 'select'`, `#required`): commands are grouped by Drush
  `namespaces` (fallback group label "Common"), hidden commands skipped, each option labelled
  `@name (@description)`. Namespace group headers are injected as disabled options keyed
  `__namespace__<label>`. The select `#description` shows the Drush application name/version.
- Adds an `arguments` textfield.

## Validation / submit

- `validateConfigurationForm()` — sets an error on `command` when it is empty or begins with
  `__namespace__` (i.e. a group header was selected instead of a real command).
- `submitConfigurationForm()` — stores `command` and `arguments` into `$this->configuration`.

## Execution — `execute()`

1. `getDrushExecutablePath()`; if empty, log an error via `$this->logger->error()` and return
   (no run).
2. Build `$command = [$drush_path, $this->configuration['command']]`.
3. Build environment (`getDrushEnvironment()`) and add
   `ECA_DRUSH_COMMAND_CONTEXT = 'running'`.
4. If `arguments` is non-empty, split it with
   `preg_split('/\s+(?=(?:[^\'"]|\'[^\']*\'|"[^"]*")*$)/', ...)` (splits on spaces outside
   quotes), scan for an argument starting with `--uri=` and, if present, set
   `DRUSH_OPTIONS_URI` in the environment; then `array_merge` the split args onto the command.
5. Run `new Process($command, DRUPAL_ROOT, $environment)` then `->mustRun()`. The command is
   passed as an **array** (Symfony escapes each element; no `/bin/sh -c` string is used).
6. On success, log the output with `$this->logger->info('Drush command executed successfully:
   @output', ...)`; on `ProcessFailedException`, log `$this->logger->error('Drush command
   failed: @error', ...)`.

## Drush binary discovery — `getDrushExecutablePath()`

- Caches to `$this->drushExecutablePath`. Tries, in order:
  `DRUPAL_ROOT . '/../vendor/bin/drush'`, `dirname(DRUPAL_ROOT) . '/vendor/bin/drush'`, and the
  literal `'drush'` — for the last, runs `shell_exec('which drush 2>/dev/null')` and uses the
  trimmed path if the file exists. Returns `''` if none resolve.

## Environment — `getDrushEnvironment()`

- Ensures `HOME` (from `$_ENV`/`$_SERVER`, else `sys_get_temp_dir()` if writable — Drush needs
  it), copies `PATH` from `getenv('PATH')`, and sets `PHP` to `PHP_BINARY` when defined.

## Operating notes

- The command and arguments are taken verbatim from the ECA model configuration; there is no
  allow-list of commands at run time (the UI select is just an authoring convenience).
- Output goes only to the logger, not back into the ECA token/context, so downstream actions
  cannot read the command result in this release.
