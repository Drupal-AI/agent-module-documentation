<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flex Processor is a developer framework that lets you attach `DataProcessor` plugins to entities, fields, custom value objects, or any other data structure and transform them into structured PHP arrays through a single service call, `\Drupal::service('plugin.manager.flex_processor')->process($value, $options)`.

---

The module provides a Drupal plugin type (annotation `@DataProcessor`, interface `DataProcessorInterface`, manager service `plugin.manager.flex_processor`) plus base classes for writing processors. When you pass any value to the manager's `process()` method, `DataProcessorManager::getComponentType()` classifies it: an `EntityInterface` becomes `{type: entity-type-id, bundle: bundle, variant}`, a `FieldItemListInterface` becomes `{type: "field", bundle: field-type, variant}`, a `DataComponent` value object becomes `{type: "component", bundle: component-bundle, variant}`, and anything else fires the `UnknownDataProcessorEvent` so a subscriber can assign a type and bundle. The manager builds a map of every plugin keyed by `type.bundle.variant`, resolves the plugin id (falling back from the requested variant to the `default` variant), instantiates it, and calls `preProcess()` — which in the base class simply calls the plugin's `process()`. The `variant` annotation property lets you register several processors for the same entity/bundle (e.g. `card` vs `teaser` output), and processors call `$this->dataProcessorManager->process()` recursively to descend into referenced entities and fields. There is **no** configuration UI, config object, route, or permission; behaviour is defined entirely in code. The module ships built-in field processors (`FieldBoolean`, `FieldDecimal`, `FieldFloat`, `FieldDateTime`, `FieldPlainText`, `FieldFormattedText`, `FieldList`, `FieldLink`, `FieldFile`, `FieldImage`, `FieldEntityReference`) that turn common core field types into JSON-friendly values, and it is aimed primarily at building decoupled/API response payloads, though it works in any context where you need repeatable data transformation.

---

- Turn a loaded node into a structured array for a JSON API response with an entity processor.
- Produce different output shapes for the same bundle using the `variant` annotation property (e.g. `card`, `teaser`, `full`).
- Recursively process a node and its referenced fields in one call via `$this->dataProcessorManager->process()`.
- Serialise a core `boolean`, `decimal`, `float`, or `integer`/`string` field into a plain scalar with the built-in field processors.
- Format a `datetime` field through `date.formatter` by passing `type`/`format`/`timezone` options to `field_datetime`.
- Resolve a `list_*` field to its allowed-value label by passing `['format' => 'value']` to `field_list`.
- Emit a `link` field as a `{label, url}` pair with the generated URL via `field_link`.
- Emit a `file` field as `{type: 'file', url}` with an absolute file URL via `field_file`.
- Emit an `image` field with original plus image-style URLs, alt text, and width/height/orientation metadata via `field_image`.
- Request one or more image styles for an image field by passing `['style' => 'thumbnail']` (or an array of styles).
- Render a formatted-text field through core `check_markup()` (honouring its text format) via `field_formatted_text`.
- Follow an `entity_reference` / `entity_reference_revisions` field and process the referenced entity via `field_entity_reference`.
- Wrap an arbitrary array in a `DataComponent` value object (`new DataComponent($bundle, $data)`) and process it with a `component` plugin.
- Read nested values from a `DataComponent` using dot-notation (`$component->get('items.0.title')`).
- Build a "feed"/list component processor that maps over items and re-processes each with a chosen variant.
- Map a non-Drupal object (plain PHP object, DTO) to a processor by subscribing to `UnknownDataProcessorEvent` and setting its type/bundle.
- Register a completely custom `type` of processor without touching the module by defining a new annotation `type` string.
- Translate an entity to the request-context language automatically by passing a `langcode` option to an entity processor (`EntityDataProcessor::preProcess()`).
- Return `NULL` cleanly for empty single/multi-value fields (handled by `FieldDataProcessor::preProcess()`).
- Collapse single-cardinality fields to a scalar and keep multi-value fields as arrays automatically.
- Centralise all "how do we shape this entity for the frontend" logic in versioned plugin classes instead of ad-hoc controllers.
- Reuse the same processors across REST resources, custom controllers, Twig preprocess, and queue workers.
- Override or alter discovered processors through the `flex_processor_processor_info` alter hook.
- Provide a stable, cache-backed processor registry (definitions cached under `flex_processor_processor_plugins`).
