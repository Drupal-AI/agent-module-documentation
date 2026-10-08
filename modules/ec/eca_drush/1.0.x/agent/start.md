<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Drush Integration (eca_drush) — agent index

Adds **one ECA action plugin** that runs a Drush command with arguments from inside an ECA
(Event-Condition-Action) model. Package `ECA`. Depends on `eca` (`eca:eca`) and Composer
`drush/drush >= 13.0.0`. Core `^11.1`. License GPL-2.0-or-later. Version-dir 1.0.x (installed
release 1.0.0-alpha2).

- **The action plugin — id, config keys, form, execution, environment, logging** →
  [plugins/execute-drush-command-action.md](plugins/execute-drush-command-action.md)

## What it actually is (from source)

- Exactly one PHP class: `ExecuteDrushCommandAction` in
  `src/Plugin/Action/ExecuteDrushCommandAction.php`, extending
  `Drupal\eca\Plugin\Action\ConfigurableActionBase`.
- Annotated `@Action(id = "eca_drush_simple_execute_drush_command", label = "Execute Drush
  command", eca_version_introduced = "2.1.4")`.
- No routes, no services file, no permissions file, no config schema/install, no `.module`,
  no `.install`, **no Drush command classes** — it *calls* Drush, it does not *define* Drush
  commands. Ships only `LICENSE.txt`, `composer.json`, `eca_drush.info.yml`, and the one class.

## Mechanism (summary)

- The action's config has two keys: `command` (a Drush command name) and `arguments` (free
  text). `execute()` locates the Drush binary, builds an array command
  `[$drush_path, $command, ...$arguments]`, and runs it with Symfony `Process` (array form,
  not a shell string) from `DRUPAL_ROOT`.
- The config form runs `drush list --format=json` to populate a namespace-grouped select of
  available commands.
- Details, all methods, and the environment/logging behavior are in the solution doc above.
