# Extend — events & service overrides

Default Content has no hooks in a `.api.php`; you extend it through two events and by
overriding its services.

## Events

Constants on `Drupal\default_content\Event\DefaultContentEvents`:

| Constant | String name | Fired | Event object |
|---|---|---|---|
| `DefaultContentEvents::IMPORT` | `default_content.import` | After a module's content has been imported. | `ImportEvent` |
| `DefaultContentEvents::EXPORT` | `default_content.export` | When an entity is exported. | `ExportEvent` |

### `ImportEvent` (`Drupal\default_content\Event\ImportEvent`)
- `getImportedEntities()` → `ContentEntityInterface[]` that were created.
- `getModule()` → the module machine name that provided the content.

### `ExportEvent` (`Drupal\default_content\Event\ExportEvent`)
- `getExportedEntity()` → the `ContentEntityInterface` being exported.

### Example subscriber

```php
use Drupal\default_content\Event\DefaultContentEvents;
use Drupal\default_content\Event\ImportEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyContentSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [DefaultContentEvents::IMPORT => 'onImport'];
  }

  public function onImport(ImportEvent $event): void {
    foreach ($event->getImportedEntities() as $uuid => $entity) {
      // e.g. post-process, index, or log entities from $event->getModule().
    }
  }
}
```

## Overriding services

All three core services are plain, un-tagged services and can be decorated or replaced in a
`{yourmodule}.services.yml`:

- `default_content.importer` (`Importer` / `ImporterInterface`) — the import pipeline.
- `default_content.exporter` (`Exporter` / `ExporterInterface`) — the export pipeline.
- `default_content.content_entity_normalizer`
  (`ContentEntityNormalizer` / `ContentEntityNormalizerInterface`) — swap this to change the
  YAML shape entities serialize to / from.

`default_content.config_subscriber` (`DefaultContentConfigSubscriber`) subscribes to
`ConfigEvents::IMPORT` and calls the importer for every module installed during a config sync —
so importing content also happens as part of configuration import, not only module install.
