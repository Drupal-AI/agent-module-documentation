# Events & extension points

## Source-row event
`src/Event/MigrateEvents.php` defines `MigrateEvents::PREPARE_ROW`. migrate_plus dispatches a
`MigratePrepareRowEvent` (`src/Event/MigratePrepareRowEvent.php`) for every source row read
(via its `hook_migrate_prepare_row()` implementation), letting any module inspect/modify the
`Row`, source plugin and migration before processing:

```php
use Drupal\migrate_plus\Event\MigrateEvents;
use Drupal\migrate_plus\Event\MigratePrepareRowEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [MigrateEvents::PREPARE_ROW => 'onPrepareRow'];
  }
  public function onPrepareRow(MigratePrepareRowEvent $event): void {
    $row = $event->getRow();
    // $event->getSource(), $event->getMigration()
    $row->setSourceProperty('computed', strtoupper($row->getSourceProperty('title')));
  }
}
```

## Plugin extension points
Add your own `data_parser`, `data_fetcher`, or `authentication` plugin — see
[../plugins/data-plugins.md](../plugins/data-plugins.md). Alter the discovered parser list via
the `hook_data_parser_info_alter()` alter hook (registered by `DataParserPluginManager`).

## Migration alter
migrate_plus runs `hook_migration_plugins_alter()` first (it reorders implementations) to
merge each group's `shared_configuration` into member migrations before other modules alter
them.
