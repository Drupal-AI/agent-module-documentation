# Extending the map (events)

Sophron builds its active map by dispatching an event during initialization; subscribe to it to
add, remove or correct mappings in code.

- **Event class:** `Drupal\sophron\Event\MapEvent`
- **Event name / constant:** `MapEvent::INIT` = `sophron.map.initialize`
- The event exposes `getMapClass()` and an `addError(method, args, type, message)` collector;
  handlers mutate the map (add/remove type↔extension mappings) as it is set up.

Sophron's own `EventSubscriber\SophronEventSubscriber::initializeMap()` listens on
`MapEvent::INIT` and applies the configured `map_commands` from settings. Add your own
subscriber the same way:

```php
public static function getSubscribedEvents(): array {
  return [MapEvent::INIT => 'onInit'];
}
public function onInit(MapEvent $event): void {
  // e.g. add a custom extension mapping to $event's map class.
}
```

The `sophron_guesser` submodule uses this API to back Drupal core's MIME type guesser with
Sophron's map.
