<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic config update API (for `hook_update_N`)

When shipping a new Open Y distribution version, a module's `openy_*.install` file uses these
services to push new config while respecting sites' customisations.

## Update a single nested property — `openy_upgrade_tool.param_updater`
`ConfigParamUpgradeTool` extends config_import's `ConfigParamUpdaterService`. Updates only one
(possibly deeply nested) property of a config, leaving the rest of a customised config intact.

```php
$config = \Drupal::service('extension.list.module')->getPath('openy_media_image')
  . '/config/install/views.view.images_library.yml';
$config_importer = \Drupal::service('openy_upgrade_tool.param_updater');
// (path-to-config-file, config name, dotted property path)
$config_importer->update($config, 'views.view.images_library',
  'display.default.display_options.pager');
```

## Re-import full configs / a directory — `openy_upgrade_tool.importer`
`ConfigUpdater`. Point it at a directory, then import named configs.

```php
$config_dir = \Drupal::service('extension.list.module')->getPath('openy_media_image')
  . '/config/install';
$config_importer = \Drupal::service('openy_upgrade_tool.importer');
$config_importer->setDirectory($config_dir);
$config_importer->importConfigs(['views.view.images_library', 'views.view.example_view']);

// Simplified single-config import (skips the full-site export to temp + the config filter):
$config_importer->importConfigSimple('views.view.images_library');
```

## Resolve conflicts in bulk — `openy_upgrade_log.manager`
```php
$mgr = \Drupal::service('openy_upgrade_log.manager');

// Force distribution version (drops manual changes):
$mgr->loadByName('core.entity_form_display.node.landing_page.default')->applyOpenyVersion();

// Keep the site's current version, mark reviewed:
$mgr->loadByName('user.role.anonymous')->applyCurrentActiveVersion();

// Manual merge: import a resolved YAML you assembled (e.g. from the sync dir):
use Drupal\Core\Serialization\Yaml;
use Drupal\Core\Config\FileStorageFactory;
$config_dir = FileStorageFactory::getSync();
$data = Yaml::decode(file_get_contents($config_dir
  . '/core.entity_form_display.node.landing_page.default.yml'));
$mgr->updateExistingConfig('core.entity_form_display.node.landing_page.default', $data);
```

Manager helpers of note: `loadByName($config_name)`, `load($id)`,
`readConfigFromExtensions($config_name)` (returns the shipped YAML data),
`applyOpenyVersion($name)`, `updateExistingConfig($name, $data, $delete_log = FALSE)`,
`isForceMode()`, `isManuallyChanged($name)`, `getUpgradeStatusDetails()`.

## Suppress tracking of a change class — `config_event_ignore` plugin type
Plugin manager `plugin.manager.config_event_ignore`, annotation `@ConfigEventIgnore`, base
`ConfigEventIgnoreBase`. `ConfigEventSubscriber::onSavingConfig()` runs each plugin's ignore check
(`validateConfigDiff()`) and skips logging when a plugin matches. Ships one plugin, `Views`, to
ignore Views-only churn. Add a plugin in `src/Plugin/ConfigEventIgnore/` to exclude your own class
of noise.

## Key implementation facts
- The write path (`updateExistingConfig` / `applyOpenyVersion`) runs a **config_import batch**
  (`ConfigImporterBatch`), then marks the log resolved and (optionally) deletes it.
- `getOpenyConfigList()` decides what is "Open Y config" by scanning every module/theme whose
  **machine name contains `openy`** for files under `config/install` and `config/optional`.
- `ConfigEventSubscriber` distinguishes a distribution import from a manual edit via the global
  `$_openy_config_import_event` flag (TRUE only during Open Y imports).
