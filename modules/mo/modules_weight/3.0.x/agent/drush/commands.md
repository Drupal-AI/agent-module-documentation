<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `ModulesWeightCommands` (registered via `drush.services.yml`).

## `mw-list` (alias `mw-l`)

Prints a table of modules with `name`, `machine_name`, `weight`, `package`.

- `--force` — include Core modules even when `show_system_modules` is off.

```bash
drush mw-list
drush mw-list --force
```

## `mw-reorder` (alias `mw-r`)

Read or set a module's weight.

- `drush mw-reorder <module>` — prints the module's current weight.
- `drush mw-reorder <module> <weight>` — sets the weight (calls `module_set_weight()`).
- `--minus` — treat the given weight as negative (e.g. run earlier).
- `--force` — allow reordering a Core module even if `show_system_modules` is disabled
  (otherwise you are prompted to confirm).

```bash
drush mw-reorder pathauto            # show current weight
drush mw-reorder pathauto 5          # set weight to 5
drush mw-reorder pathauto 3 --minus  # set weight to -3
```

Validation: the module must exist/be installed, and the weight must be digits.

## `mw-show-system-modules` (alias `mw-ssm`)

Read or toggle the `show_system_modules` option (config `modules_weight.settings`).

- `drush mw-show-system-modules` — prints whether Core reordering is Activated/Disabled.
- `drush mw-show-system-modules on` / `off` — enable/disable it.

```bash
drush mw-show-system-modules
drush mw-show-system-modules on
```

Argument must be `on` or `off`.
