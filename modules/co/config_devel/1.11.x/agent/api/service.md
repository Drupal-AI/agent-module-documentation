# Config Devel API — service, subscribers, event

## Service `config_devel.importer_exporter`

Class `Drupal\config_devel\ConfigImporterExporter`. Public methods:

- `importConfig(string $filename, string $original_hash = '', string $contents = ''): ?string`
  — import a YAML file (or the given `$contents`) into active storage; returns the new file
  hash, or falsy if the content hash matched `$original_hash` (nothing to do). This is the
  core of "single import".
- `writeBackConfig(\Drupal\Core\Config\Config $config, array $file_names): array` — write a
  config object's current data to each of `$file_names`; returns the files written. Fires the
  `config_devel.save` event so other modules can alter the data before it hits disk.

## Event subscribers

- `config_devel.auto_import_subscriber` (`ConfigDevelAutoImportSubscriber`) — on
  `KernelEvents::REQUEST` runs `autoImportConfig()`, which walks `config_devel.settings`
  `auto_import` and imports any file whose hash changed (updating the stored hash). Also
  exposes `importOne($filename, $original_hash, $contents)`.
- `config_devel.writeback_subscriber` (`ConfigDevelAutoExportSubscriber`) — on config-save
  events writes any object listed in `auto_export` back out to its file(s).

## Event `config_devel.save`

Constant `Drupal\config_devel\Event\ConfigDevelEvents::SAVE`. Dispatched with a
`ConfigDevelSaveEvent` just before config is written to disk. Subscribe to alter what gets
exported:

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
