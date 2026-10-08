# Config Devel API — service, subscribers, event

## Service `config_devel.importer_exporter`

Class `Drupal\config_devel\ConfigImporterExporter`. Public methods:

- `importConfig(string $filename, string $original_hash = '', string $contents = ''): ?string`
  — import a YAML file (or the given `$contents`) into active storage via a core
  `ConfigImporter` over a `StorageReplaceDataWrapper`; returns the new base64 content hash, or
  NULL if the content hash matched `$original_hash` (nothing to do). The config object name is
  the file's basename minus `.yml`. This is the core of "single import".
- `writeBackConfig(\Drupal\Core\Config\Config $config, array $file_names): string[]` — write a
  config object's current data to each of `$file_names` (stripping `_core`, and `uuid` for
  config entities); returns the files actually written. Fires the `config_devel.save` event so
  other modules can alter the data (and the target file list) before it hits disk.

## Event subscribers

- `config_devel.auto_import_subscriber` (`ConfigDevelAutoImportSubscriber`) — on
  `KernelEvents::REQUEST` (priority 20) runs `autoImportConfig()`, which walks
  `config_devel.settings` `auto_import` and imports any file whose hash changed (updating the
  stored hash). Also exposes `importOne($filename, $original_hash, $contents)`, which the
  `cdi1` command path relies on. Note this subscriber carries its own import implementation
  (via the config entity storage / config factory), separate from the service's
  `importConfig()` (which uses `ConfigImporter`); both are marked with a TODO to consolidate.
- `config_devel.writeback_subscriber` (`ConfigDevelAutoExportSubscriber`) — on
  `ConfigEvents::SAVE` and `ConfigEvents::RENAME` (priority 10) writes any config object whose
  name matches a basename in `auto_export` back out to the matching file(s).

## Event `config_devel.save`

Constant `Drupal\config_devel\Event\ConfigDevelEvents::SAVE`. Dispatched with a
`ConfigDevelSaveEvent` just before config is written to disk (by both the service and the
auto-export subscriber). Subscribe to alter what gets exported:

```php
use Drupal\config_devel\Event\ConfigDevelEvents;
use Drupal\config_devel\Event\ConfigDevelSaveEvent;

public static function getSubscribedEvents(): array {
  return [ConfigDevelEvents::SAVE => 'onSave'];
}

public function onSave(ConfigDevelSaveEvent $event): void {
  $data = $event->getData();          // array being written
  // ... mutate $data ...
  $event->setData($data);
  // $event->getFileNames() / setFileNames() control target files.
}
```

Most callers do not need this service directly — the Drush commands and the two subscribers
cover the normal workflows (see [drush/commands.md](../drush/commands.md) and
[configure/settings.md](../configure/settings.md)).
