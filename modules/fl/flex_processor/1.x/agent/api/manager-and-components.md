<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manager service, DataComponent, and the unknown-object event

## Invoking a processor

The single entry point is the manager service `plugin.manager.flex_processor`
(`Drupal\flex_processor\Plugin\DataProcessorManager`):

```php
$data = \Drupal::service('plugin.manager.flex_processor')->process($value, [
  'variant'  => 'card',   // default 'default'
  'langcode' => 'de',     // default NULL (entity processors use it to translate)
]);
```

Inside a plugin, use the injected `$this->dataProcessorManager->process(...)` to recurse into
fields and referenced entities.

### Dispatch algorithm (`DataProcessorManager`)

1. `process()` merges option defaults `{variant: 'default', langcode: NULL}`.
2. `getComponentType($value, $options)` classifies the value into `{type, bundle, variant}`:
   - `EntityInterface` → `type = $value->getEntityTypeId()`, `bundle = $value->bundle()`.
   - `FieldItemListInterface` → `type = "field"`, `bundle = field definition's field type`.
   - `DataComponentInterface` → `type = "component"`, `bundle = $value->bundle()`.
   - anything else → dispatch `UnknownDataProcessorEvent` and read its type/bundle back.
3. `getProcessor()` uses `getProcessorMap()` (all definitions keyed `type.bundle.variant`), tries
   the exact key, then the `type.bundle.default` key, else throws
   `MissingPluginImplementationException` (`src/Exception/`).
4. The plugin is instantiated with `createInstance()` and its `preProcess()` is called (base:
   forwards to `process()`; entity/field base classes do the translation/iteration described in
   [../plugins/data-processor.md](../plugins/data-processor.md)).

The plugin map is memoised on the manager instance and cache-backed
(`flex_processor_processor_plugins`); `drush cr` after adding plugins.

## DataComponent value object

`Drupal\flex_processor\Component\DataComponent` (`src/Component/DataComponent.php`) wraps an
arbitrary array so it can be routed to a `type = "component"` processor:

```php
use Drupal\flex_processor\Component\DataComponent;

$feed = new DataComponent('feed', ['items' => $entities]);
$out  = \Drupal::service('plugin.manager.flex_processor')->process($feed);
```

- `bundle(): string` — the component bundle, matched against a plugin whose `type = "component"`
  and `bundles` contains that string.
- `get(string $keyPath): mixed` — dot-notation read (`'items.0.title'`); throws
  `InvalidComponentKeyException` (`\InvalidArgumentException`) if any key is missing.
- Implements `IteratorAggregate` — `foreach ($component as $key => $value)` yields the raw data.

A `component` processor extends `ComponentDataProcessor` and typically maps over items, re-invoking
the manager per item:

```php
/**
 * @DataProcessor(id="feed", label=@Translation("Feed"), type="component", bundles={"feed"})
 */
class Feed extends ComponentDataProcessor {
  public function process(mixed $component, array $options = []): mixed {
    $items = [];
    foreach ($component->get('items') as $item) {
      $items[] = $this->dataProcessorManager->process($item, ['variant' => 'card']);
    }
    return ['items' => $items, 'total' => count($items)];
  }
}
```

## Handling arbitrary objects — UnknownDataProcessorEvent

When the manager cannot classify a value it dispatches
`Drupal\flex_processor\Event\UnknownDataProcessorEvent` (`src/Event/`, event name constant
`UnknownDataProcessorEvent::NAME = 'unknown_data_processor_event'`; unmatched default type/bundle is
`'unknown'`). A subscriber inspects the object and assigns a type/bundle so a plugin can be found:

```php
public static function getSubscribedEvents() {
  return [UnknownDataProcessorEvent::NAME => 'register'];
}

public function register(UnknownDataProcessorEvent $event) {
  $data = $event->getDataSource();          // the object being processed
  if (isset($data->pepe)) {
    $event->setDataSourceType('custom');    // -> plugin type
    $event->setDataSourceBundle('pepe');    // -> plugin bundle
    // $event->setDataSourceVariant('x');   // optional; starts as the requested variant
  }
}
```

Getters: `getDataSource()`, `getDataSourceType()`, `getDataSourceBundle()`,
`getDataSourceVariant()`, and `getDataSourceComponentType()` (returns the `{type, bundle, variant}`
array the manager consumes). A plugin then handles it by extending `DataProcessorBase` with a
matching `type`/`bundles` annotation.

## What the module does *not* provide

No routes, controllers, forms, permissions, config objects/schema, install hooks, Drush commands, or
`.module` file. It renders nothing itself: the returned structure and any escaping/serialisation of
it are the responsibility of the calling code (e.g. your REST resource or controller). Built-in
processors that emit user-facing text already sanitise where appropriate — `field_formatted_text`
uses core `check_markup()` and `field_image` runs alt text through `Xss::filter()`.
