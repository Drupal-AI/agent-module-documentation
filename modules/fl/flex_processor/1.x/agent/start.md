<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flex Processor (flex_processor) — agent index

A **developer framework** that transforms any Drupal value (entity, field item list, custom value
object, or arbitrary object) into a structured PHP array via pluggable **DataProcessor** plugins.
One service call — `\Drupal::service('plugin.manager.flex_processor')->process($value, $options)` —
classifies the value and dispatches to the matching plugin, whose `process()` you write. Package
`Development`. Version **1.0.0-beta4** (doc dir `1.x`). Core `^10 || ^11`, PHP `>=8.1`. License
GPL-2.0-or-later. **No dependencies, no routes, no permissions, no forms, no config, no admin UI.**

- **The DataProcessor plugin type, annotation, base classes, and built-in field processors** →
  [plugins/data-processor.md](plugins/data-processor.md)
- **The manager service, DataComponent value object, and the unknown-object event** →
  [api/manager-and-components.md](api/manager-and-components.md)

## What it actually is

- A plugin type: annotation `Drupal\flex_processor\Annotation\DataProcessor` (properties `id`,
  `label`, `type`, `bundles[]`, `variant` default `"default"`), interface `DataProcessorInterface`,
  discovered from any module's `src/Plugin` namespace. No `.permissions.yml`, `.routing.yml`,
  `.links.*.yml`, `.install`, `config/`, or `.module` file exists.
- One service (`flex_processor.services.yml`): `plugin.manager.flex_processor` →
  `Drupal\flex_processor\Plugin\DataProcessorManager` (extends `DefaultPluginManager`, takes the
  `@event_dispatcher`). Alter hook `flex_processor_processor_info`; plugin cache bin key
  `flex_processor_processor_plugins`.
- Base classes in `src/Plugin/`: `DataProcessorBase` (implements interface +
  `ContainerFactoryPluginInterface`, injects the manager as `$this->dataProcessorManager`),
  `EntityDataProcessor` (adds `entity.repository`, translates by `langcode` in `preProcess()`),
  `FieldDataProcessor` (`preProcess()` iterates a `FieldItemListInterface`, skips empties,
  collapses single-cardinality to a scalar), `ComponentDataProcessor` (marker subclass).
- Value object `Drupal\flex_processor\Component\DataComponent($bundle, array $data)` with
  `bundle()`, dot-notation `get('a.b.c')` (throws `InvalidComponentKeyException`), and iteration.
- Event `Drupal\flex_processor\Event\UnknownDataProcessorEvent` (name
  `unknown_data_processor_event`) to classify objects the manager does not recognise.
- Built-in field processors under `src/Plugin/FieldDataProcessors/`: `field_boolean`,
  `field_decimal`, `field_float`, `field_datetime`, `field_plain_text` (string/string_long/
  integer/email), `field_formatted_text` (text/text_long/text_with_summary), `field_list`,
  `field_link`, `field_file`, `field_image`, `field_entity_reference`.

## How dispatch works (from `DataProcessorManager`)

- `process($value, $options)` merges defaults `{variant: 'default', langcode: NULL}`, calls
  `getComponentType()` to derive `{type, bundle, variant}`, then `getProcessor()`.
- `getComponentType()`: `EntityInterface` → `{entityTypeId, bundle}`; `FieldItemListInterface` →
  `{"field", field-type}`; `DataComponentInterface` → `{"component", component-bundle}`; anything
  else → dispatch `UnknownDataProcessorEvent` and use its type/bundle.
- `getProcessorMap()` keys every plugin by `type.bundle.variant`; `getProcessor()` looks up the
  requested variant, falls back to the `default` variant, and throws
  `MissingPluginImplementationException` if none matches. The instance's `preProcess()` runs
  (base default just forwards to `process()`).

Developer/site-builder infrastructure — it renders nothing itself; output shape and any escaping of
returned values are the responsibility of the consuming code and the processors you write.
