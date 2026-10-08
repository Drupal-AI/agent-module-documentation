# Extending export formats (events)

Export formats are pluggable via two Symfony events in `src/Event/`. To add a format you register
an event subscriber (as the bundled `entity_reports_csv` submodule does for CSV).

## Events

| Event class | EVENT_NAME | Fired when | Mutable properties |
|---|---|---|---|
| `EntityReportsExportFormats` | `entity_reports_export_formats` | Whenever the module lists available formats (route generation, landing page, per-page download links) | `public array $exportFormats` (machine_name => label). Seeded from `DEFAULT_EXPORT_FORMATS = ['json' => 'JSON', 'xml' => 'XML']`. |
| `EntityReportsExportProcessors` | `entity_reports_export_processors` | During `export()` for any format that is **not** in `DEFAULT_EXPORT_FORMATS` (i.e. not json/xml) | `public $content`, `public $entityType`, `public array $reportFields`, `public $type`, `public array $responseHeaders` |

Registering a format via the first event makes it appear in the UI and creates the matching
`.{format}` export routes. Actually producing the file body is done by subscribing to the second
event and rewriting `$event->content` (json/xml are handled inline by the controller and never
dispatch the processors event).

## Add a format — subscriber skeleton

```php
// my_module.services.yml
// my_module.formats:
//   class: Drupal\my_module\EventSubscriber\MyFormatsSubscriber
//   tags: [{ name: event_subscriber }]
// my_module.processors:
//   class: Drupal\my_module\EventSubscriber\MyProcessorsSubscriber
//   arguments: ['@serializer']
//   tags: [{ name: event_subscriber }]

use Drupal\entity_reports\Event\EntityReportsExportFormats;
use Drupal\entity_reports\Event\EntityReportsExportProcessors;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyFormatsSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [EntityReportsExportFormats::EVENT_NAME => 'onFormats'];
  }
  public function onFormats(EntityReportsExportFormats $event): void {
    $event->exportFormats['csv'] = 'CSV';
  }
}

class MyProcessorsSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [EntityReportsExportProcessors::EVENT_NAME => 'onProcessors'];
  }
  public function onProcessors(EntityReportsExportProcessors $event): void {
    // $event->content is ['bundles' => ...] (structure) or ['bundles' => [], 'entity_types' => ...] (statistics).
    // $event->reportFields lists the enabled columns; set the body and any headers:
    $event->content = my_serialize($event->content, $event->reportFields);
    $event->responseHeaders['Content-Type'] = 'text/' . $event->type;
  }
}
```

The reference implementation is `entity_reports_csv` (`modules/entity_reports_csv/`): its formats
subscriber adds `csv`, and its processors subscriber serializes via the `serializer` service if the
`csv` encoder is available (from `csv_serialization`), otherwise it returns a notice telling the user
to enable that module.
