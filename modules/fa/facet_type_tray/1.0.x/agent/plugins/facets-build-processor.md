<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets build processor: `type_tray` (Type Tray: Merge node types)

File: `src/Plugin/facets/processor/TypeTrayProcessor.php`
Class: `Drupal\facet_type_tray\Plugin\facets\processor\TypeTrayProcessor extends ProcessorPluginBase`
implements `BuildProcessorInterface, ContainerFactoryPluginInterface`.
Annotation: `@FacetsProcessor(id = "type_tray", label = "Type Tray: Merge node types", stages = {"build" = 80})`.

This is the **display** side. During the facet build stage it converts the raw indexed values from the
Search API processor into human-readable labels.

## When it applies

`supportsFacet(FacetInterface $facet)` returns TRUE only when the facet's data definition is a
`ProcessorPropertyInterface` whose `getProcessorId()` equals `type_tray` — i.e. a facet built on the
field added by this module's Search API processor.

## What `build()` does

`build(FacetInterface $facet, array $results)` reads the ordered category map
`type_tray.settings:categories`, then for each result rewrites its display value based on its raw
value (`Result::getRawValue()`):

- Contains a dot (child `category.bundle`): splits off the bundle and sets the label to the
  `node_type` entity's `label()`, falling back to the bundle string if the type cannot be loaded.
- Equals `_none`: label is `t('Other')`.
- Otherwise (parent category key): label is `$categories[$raw_value]` (the Type Tray category name)
  if present, else the `node_type` label for that key, else the raw value.

It calls `$result->setDisplayValue($label)` and returns the results. Labels are plain strings (node
type labels / Type Tray category names / bundle machine names) handed to the Facets render pipeline,
which escapes them on output; the plugin does not build markup.

## Dependencies

Injected via `create()`: `entity_type.manager` (load node types) and `config.factory` (read
`type_tray.settings`). No request/query input.

## Operate

Enable on the facet's Processors tab ("Type Tray: Merge node types"). Without it, the facet shows the
raw `category` / `category.bundle` strings instead of readable labels.
