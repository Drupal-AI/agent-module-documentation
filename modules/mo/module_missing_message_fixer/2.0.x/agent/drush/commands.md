<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `drush.services.yml` (legacy Drush command services).

## `module-missing-message-fixer:list` (alias `mmmfl`)

Lists every ghost module — rows from `key_value` collection `system.schema` whose name no
longer maps to an installed extension. Output columns: **Name**, **Type** (always `module`).

```bash
drush module-missing-message-fixer:list
drush mmmfl
```

Prints `No Missing Modules Found!!!` when there are none. Read-only.

## `module-missing-message-fixer:fix` (alias `mmmff`)

Deletes ghost schema entries.

```bash
# fix a single ghost by machine name (only acts if it is actually a ghost)
drush module-missing-message-fixer:fix my_old_module
drush mmmff my_old_module

# fix every ghost at once
drush mmmff --all
```

Behaviour (`MmmfFixCommand::fixCommand($name, ['all' => …])`):

- **`--all`** — iterates all ghosts, and for each also deletes leftover config named
  `<module>.*` (via `config.factory`), then removes the `system.schema` `key_value` rows.
  Prints *"All missing references have been removed."*
- **`<name>`** — only if `<name>` appears in the ghost list, it deletes that
  `system.schema` `key_value` row. **Note:** the single-name path removes the key-value row
  but does **not** delete `<module>.*` config (only `--all` and the UI do that).
- No argument and no `--all` → prints *"Missing input, provide module name or run with --all"*
  (only at very-verbose verbosity).

> Caution: `--all` removes **every** ghost on the site. On a shared environment prefer the
> named form to avoid touching entries you did not create.
