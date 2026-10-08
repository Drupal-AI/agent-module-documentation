<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Import (confi) — agent index

Programmatic tool for importing/updating a **named subset** of configuration, rather than core's
all-or-nothing sync. Intended for use inside `hook_update_N()` and deploy scripts so a project can
apply *specific* config changes during development without a full `config:import`. Version 4.2.0,
core `^11`. **Machine name `config_import`** (project `confi`).

No dependencies beyond core. No settings page (`configure` is null), no routes, no forms, no
permissions of its own, no Drush commands, no plugins, no config schema. The entire surface is two
services plus one alter hook. (The project README still mentions a Features integration service and
Drush commands; neither is shipped in 4.2.0 — do not rely on them.)

- **Import/export a subset of config; update a single config property; the service methods** →
  [api/services.md](api/services.md)
- **Protecting config objects from being imported (denylist)** →
  [hooks/config-import-configs-alter.md](hooks/config-import-configs-alter.md)

Key facts:
- Service `config_import.importer` → `Drupal\config_import\ConfigImporterService`
  (implements `ConfigImporterServiceInterface`): `setDirectory()`, `getDirectory()`,
  `importConfigs(array $names)`, `exportConfigs(array $names)`.
- Service `config_import.param_updater` → `Drupal\config_import\ConfigParamUpdaterService`:
  `update($file_path, $config_name, $dotted_param)`; logs to the `config_update` channel.
- Default source/target directory is `Settings::get('config_sync_directory')`; override with
  `setDirectory()` (must be an existing dir or it throws `\InvalidArgumentException`).
- `importConfigs()` diffs a full active-config snapshot against your named files via core
  `StorageComparer`/`ConfigImporter`; naming a config whose `.yml` is missing **deletes** it.
- Alter hook `hook_config_import_configs_alter(array &$configs)` builds a denylist of config
  names excluded from every import (applied in `ConfigImporterService::filter()`).
