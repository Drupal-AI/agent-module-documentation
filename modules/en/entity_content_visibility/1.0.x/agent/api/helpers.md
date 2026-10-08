<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# entity_content_visibility — integration / API

This module is a building block for other modules. It has no UI of its own.

## Attaching the field
Add a field of type `entity_content_visibility` to your entity/bundle (in config or via a base field). The field type is `no_ui = TRUE`, so it will not appear in the Field UI "Add field" list — attach it programmatically or ship it as config. Its default widget is `entity_content_visibility`, which renders every condition plugin valid for the available contexts as vertical tabs (the same experience as core's block visibility form), excluding `current_theme`.

## Stored value format
The widget's `massageFormValues()` serializes an array keyed by condition plugin id → condition configuration, keeping only conditions whose configuration differs from their `defaultConfiguration()`. If no condition is set the field item is removed. The value is a PHP `serialize()` string stored in a long-text column.

## Evaluating visibility at runtime
```php
use Drupal\entity_content_visibility\EntityContentVisibilityChecker;

$checker = EntityContentVisibilityChecker::createFromId($container, $entity_type_id, $id);
if ($checker->isVisible()) {
  // render the entity
}
```
`isVisible()` unserializes the stored conditions, instantiates each via `plugin.manager.condition`, applies runtime contexts through `context.repository` + `context.handler`, and returns FALSE as soon as one condition evaluates FALSE (AND logic). A `ContextException` while mapping contexts is treated as the condition passing.

## Cacheability
```php
use Drupal\entity_content_visibility\EntityContentVisibilityCache;

$cache = EntityContentVisibilityCache::createFromId($container, $entity_type_id, $id);
$build['#cache']['contexts'] = $cache->getCacheContexts();
$build['#cache']['tags']     = $cache->getCacheTags();
$build['#cache']['max-age']  = $cache->getCacheMaxAge();
```
These merge the cacheability metadata of every stored condition so the host render array bubbles correct contexts/tags/max-age.

## Compatibility caveats (D9/D10)
- Both `createFromId()` helpers call `$container->get('entity.manager')`, which was removed in Drupal 9. Replace with `entity_type.manager` before use on D10.
- `EntityContentVisibilityChecker.php` declares namespace `Drupal\entityContent_visibility` (capital C) — mismatched with its PSR-4 path; the class is not autoloadable as written and needs correcting to `Drupal\entity_content_visibility`.
