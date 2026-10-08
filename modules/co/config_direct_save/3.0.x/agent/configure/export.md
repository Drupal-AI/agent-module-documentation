<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exporting configuration with Config Direct Save

## The form

- **Route:** `config_direct_save.update_configuration_form`
- **Path:** `/admin/config/development/configuration/full/update`
- **Local task:** "Update", `base_route: config.sync` (appears as a tab on
  *Configuration › Development › Configuration synchronization*, `/admin/config/development/configuration`).
- **Permission (requirement):** `export configuration` — the core permission defined by the
  `config` module. Config Direct Save has **no** `permissions.yml`; grant this core
  permission to a role to let it use the form.
- **Form class:** `Drupal\config_direct_save\Form\UpdateConfigurationForm` (form id
  `config_update_form`).

## Fields

- **Config source** (`config_directory`, required select) — the only option is the site's
  sync directory, taken from `Settings::get('config_sync_directory')`. It is not a free
  choice; the select is built as `array_flip(['sync' => Settings::get('config_sync_directory')])`.
- **Backup** (`backup`, checkbox) — when checked, the current sync directory is recursively
  copied to a sibling directory named `<sync>-<d-m-Y-H-i-s>` before anything is overwritten.
- **Update configuration** (submit).

## What submit does (`createConfigFiles()`)

1. If **Backup** is checked, recursively copy the sync directory to `<dir>-<date>`.
2. Delete all existing `*.yml` files under the sync directory (recursively; other extensions
   such as `.htaccess` are left alone).
3. For every active config object (`configManager->getConfigFactory()->listAll()`), write
   `<name>.yml` containing `Yaml::encode($config->getRawData())`.
4. For every additional config collection (e.g. `language.<langcode>`), recreate the
   `collection/path/` subdirectory and write each collection object's YAML there.
5. Show the message "The configuration has been uploaded."

Net effect: a full active-config dump to files, equivalent to `drush config:export` but from
the UI and **without** the config-diff review step. There are no options to choose which
config is exported — it is always the entire active configuration.

## Notes / gotchas

- The web server user must be able to write (and create backup subdirectories) in the sync
  directory. The README suggests `chmod -R 775` on the config directory.
- There is **no** import/synchronize behaviour here — this only writes active config **out**
  to files. Use core's Synchronize screen (or `drush config:import`) to import.
- No config object is created by this module; `configure` in `*.info.yml` is `null`
  (the form is reached via the `config.sync` task, not a `configure` link).
