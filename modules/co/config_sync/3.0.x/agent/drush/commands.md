<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `Drupal\config_sync\Drush\ConfigSyncCommands`.

## `config-sync-list-updates` (alias `cs-list`)

Lists every extension that has configuration updates available (from its changelist).

```bash
drush config-sync-list-updates
drush cs-list
```

- Default fields: `extension`, `type` (operation: create/update), `label`.
- All fields: `type` (operation type), `id` (config id), `collection`, `label`,
  `extension_type` (module/theme), `extension`.
- Supports `--format=` (default `table`); e.g. `--format=json`.
- Output comes from `config_sync.lister->getExtensionChangelists()`. On a site with no
  pending extension config changes the list is empty.

## `--update-mode` option on core `config-distro-update`

config_sync does not define its own apply command; it **augments** config_distro's
`config-distro-update` with an option:

```bash
drush config-distro-update --update-mode=2
```

- `--update-mode` values: `1` merge, `2` partial reset, `3` full reset.
- Implemented via a `@hook option config-distro-update` (declares the option) plus a
  `@hook pre-command config-distro-update` that writes the value to
  **state `config_sync.update_mode`** before the update runs.
- Omit the option to use whatever mode is already in state (default: merge).

There are no other config_sync Drush commands. Applying updates themselves is
`config-distro-update` (from config_distro); config_sync only lists updates and sets the mode.
