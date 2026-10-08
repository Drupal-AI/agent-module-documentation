# The `google_tag_event` plugin type

Optional. A plugin lets you move the code that *builds* an event's `dataLayer` payload out of the
`setEvent()` caller and into a reusable class. You do not need a plugin to push an event — passing a
data array to `setEvent()` works on its own; a plugin only runs when its `id` matches the event name.

## Type definition (in this module)

| Piece | Value |
| --- | --- |
| Manager service | `plugin.manager.google_tag_events` |
| Manager class | `Drupal\google_tag_events\GoogleTagEventsPluginManager` |
| Discovery directory | `Plugin/google_tag_event` |
| Annotation | `@Plugin` (`Drupal\Component\Annotation\Plugin`) — keys `id`, `label`, optional `weight` |
| Interface | `Drupal\google_tag_events\GoogleTagEventPluginInterface` — `process(?array $data = NULL)` |
| Base class | `Drupal\google_tag_events\GoogleTagEventsPluginBase` |
| Alter hook | `hook_google_tag_events_alter(&$definitions)` |
| Cache key | `google_tag_events_plugins` |

`GoogleTagEventsPluginBase` implements `ContainerFactoryPluginInterface` and stores
`$configuration['data']` into `protected array $data`, so `process()` can fall back to `$this->data`.

## Add a plugin

Place the class in your module's `src/Plugin/google_tag_event/`:

```php
namespace Drupal\my_module\Plugin\google_tag_event;

use Drupal\google_tag_events\GoogleTagEventsPluginBase;

/**
 * @Plugin(
 *   id = "example_event_node_view",
 *   label = @Translation("Node page visit event"),
 *   weight = 10
 * )
 */
class ExampleEventNodeView extends GoogleTagEventsPluginBase {

  public function process(?array $data = NULL) {
    $data = $data ?? $this->data;
    return [
      'event' => 'node_view',
      'title' => $data['node']->getTitle(),
    ];
  }

}
```

Then raise it — the event **name must equal the plugin `id`** for `process()` to be called:

```php
google_tag_events_service()->setEvent('example_event_node_view', ['node' => $node]);
// → dataLayer.push({ event: 'node_view', title: 'Some node title' });
```

## Notes

- Whatever `process()` returns becomes the pushed payload; if it omits `event`, no default is added
  (unlike the plugin-less path, which sets `event` to the name). Include an `event` key yourself.
- `weight` (optional annotation key) is collected by `GoogleTagEvents::getEventsWeightsList()` and
  used client-side to order `dataLayer.push` calls when several events are queued (lower first).
- For dependency injection, override `create()`/`__construct()` as usual — the base class already
  wires the container.
- See the shipped `tests/modules/gtm_events_test` for working example plugins (homepage view,
  article view, form submit, views display, 403/404).
