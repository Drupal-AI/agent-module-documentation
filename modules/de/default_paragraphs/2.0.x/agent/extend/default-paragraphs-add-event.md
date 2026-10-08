# DefaultParagraphsEvents::ADDED event

When the widget seeds a default paragraph on a new host entity, it dispatches an event **right
before** the paragraph is placed into the field, letting your module inspect, mutate, or
replace that paragraph entity (e.g. to set default field values).

## What's dispatched
In `DefaultParagraphsWidget::formMultipleElements()`:

```php
$paragraphs_entity = Paragraph::create(['type' => $default_type_name]);
$this->eventDispatcher->dispatch(
  new DefaultParagraphsAddEvent($paragraphs_entity, $target_bundle),
  DefaultParagraphsEvents::ADDED
);
```

- **Event name constant:** `DefaultParagraphsEvents::ADDED` = `'default_paragraphs.added'`
  (`src/Events/DefaultParagraphsEvents.php`).
- **Event object:** `DefaultParagraphsAddEvent` (`src/Events/DefaultParagraphsAddEvent.php`),
  a `Drupal\Component\EventDispatcher\Event`.

## Event object API
- `getParagraphEntity(): \Drupal\paragraphs\ParagraphInterface` — the freshly created (unsaved)
  paragraph about to be seeded. Set field values directly on it.
- `setParagraphEntity(ParagraphInterface $paragraph_entity): void` — replace the paragraph
  entity entirely.
- `getTargetBundle(): string` — the host field's target bundle, so you can vary behavior per
  bundle.

The paragraph is not yet saved, so mutations you make persist as the default value the editor
sees on the add form.

## Subscribe to it
`mymodule/src/EventSubscriber/MyDefaultParagraphsSubscriber.php`:

```php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\default_paragraphs\Events\DefaultParagraphsAddEvent;
use Drupal\default_paragraphs\Events\DefaultParagraphsEvents;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyDefaultParagraphsSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [DefaultParagraphsEvents::ADDED => 'onParagraphAdded'];
  }

  public function onParagraphAdded(DefaultParagraphsAddEvent $event): void {
    $paragraph = $event->getParagraphEntity();
    // Only touch a specific paragraph type.
    if ($paragraph->bundle() === 'text') {
      $paragraph->set('field_body', 'Default body copy…');
    }
    // Host bundle is available if behavior should differ per content type.
    // $event->getTargetBundle();
  }

}
```

Register it in `mymodule.services.yml`:

```yaml
services:
  mymodule.default_paragraphs_subscriber:
    class: Drupal\mymodule\EventSubscriber\MyDefaultParagraphsSubscriber
    tags:
      - { name: event_subscriber }
```

Notes:
- The event fires once per seeded default paragraph, only on **new** host entities with an
  empty field (see [../configure/widget.md](../configure/widget.md)).
- To replace rather than mutate, build your own `Paragraph` and call
  `$event->setParagraphEntity($new)`.
