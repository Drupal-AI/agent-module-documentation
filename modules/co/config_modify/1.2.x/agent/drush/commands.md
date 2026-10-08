# Drush — Config Modify

Defined in `src/Commands/ConfigModifyCommands.php` (service `config_modify.commands`).

## `config-modify:create` (alias `cmc`)

Interactively scaffold a `config/modify/<module>.<name>.yml` file by diffing config. Prompts:

1. Which (non-core) module should contain the file.
2. A machine-name for the modification.
3. Direction: **from disk to database** (default) or **from database to disk** — controls
   which side is the "from" and which is the "to" of the produced diff.
4. Which config objects to include (multiselect from `config.factory` list).
5. Optional extra `dependencies` (modules and/or config objects).

For each selected config it diffs on-disk `config/install`|`config/optional` against the active
(database) value using `UpdateDefinitionCreator::produceDiff`, skipping unchanged or
disk-missing config, and writes the resulting `items` (+ `dependencies`) YAML into the module's
`config/modify/` folder (prompting before overwrite).

```bash
drush config-modify:create
```

## `config-modify:pre-update` (alias `cmpu`)

Mark any newly-added, currently-applicable `config/modify` files as applied **before** running
database updates, so they don't fire unexpectedly during `drush updb` (calls
`config.installer::markAvailableModificationsAsApplied()`). Run it before deploying update
hooks that themselves introduce new modification files.

```bash
drush config-modify:pre-update
```
