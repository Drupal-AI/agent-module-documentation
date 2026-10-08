<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API processor: content_type_or_other

Class `Drupal\facets_content_type_or_other\Plugin\search_api\processor\ContentTypeOrOther`
(`src/Plugin/search_api/processor/ContentTypeOrOther.php`), extends `ProcessorPluginBase`.

## Plugin definition

`@SearchApiProcessor` annotation: `id = "content_type_or_other"`, label *Content type or Other*,
`stages = { "add_properties" = 0 }`, `locked = true`, `hidden = true`. Because it is `locked`/`hidden`,
it is not toggled on the index's Processors tab directly — you add its field instead (below).

## What it adds

`getPropertyDefinitions()` returns, only when `$datasource` is NULL (an index-level property), one
`ProcessorProperty` keyed `content_type_or_other`: label *Content type or other*, `type = 'string'`,
`processor_id = content_type_or_other`. Add this as a field on the Search API index (Fields tab →
"Content type or other").

## Index-time value logic (`addFieldValues(ItemInterface $item)`)

1. Only processes items whose datasource id is `entity:node`.
2. Loads the node (`$item->getOriginalObject()->getValue()`), its bundle machine name (`$node->bundle()`)
   and its **bundle label** (`$node->type->entity->label()`).
3. Filters index fields to the `content_type_or_other` property path (`getFieldsHelper()->filterForPropertyPath`).
4. For each such field, computes `$value`:
   - default `'Other'`;
   - if **no** first-order types are configured → the plain bundle label (all types shown by their label);
   - else if the node's bundle is in the first-order map → its configured label override.
5. Dispatches a `SetIndexedValue` event (`$node`, `$value`) via the event dispatcher so subscribers can
   rewrite the value, then reads it back with `$event->getValue()`.
6. `$field->addValue($value)`.

## First-order config (`getFirstOrderContentTypes()`)

Reads `\Drupal::config('facets_content_type_or_other.settings')->get('first_order_config')` and builds
`[bundle => label_override]` for rows whose `first_order` flag is set (memoised on `$firstOrderContentTypes`).
This is the same config written by the settings form ([../config/settings.md](../config/settings.md)).

## Event dispatcher

`create()` injects `event_dispatcher`; `getEventDispatcher()` falls back to `\Drupal::service('event_dispatcher')`.
See the event doc: [../api/set-indexed-value-event.md](../api/set-indexed-value-event.md).

## Operate

After adding the field and configuring first-order types, **re-index** so every item carries the computed
value. Only node datasources contribute a value; other datasources index nothing for this field.
