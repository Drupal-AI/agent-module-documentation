<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `facets_custom_label` processor plugin

This module **implements** a Facets processor plugin; it does not define a new plugin type.
The plugin plugs into Facets' existing `facets_processor` plugin manager.

## Plugin definition

`src/Plugin/facets/processor/FacetsCustomLabelProcessor.php`:

```php
#[FacetsProcessor(
  id = "facets_custom_label",
  label = "Facets custom label processor",
  stages = { "build" = 50 },
)]
class FacetsCustomLabelProcessor extends ProcessorPluginBase implements BuildProcessorInterface
```

- Runs only at the **build** stage (default weight 50) — after results and their raw/display
  values exist.
- Constants: `SEPARATOR = '|'`, `ORIGIN__RAW = 'r'`, `ORIGIN__DISPLAY = 'd'`.

## `build(FacetInterface $facet, array $results)`

1. Reads `replacement_values` from the processor configuration and splits it on line breaks.
2. For each row it needs at least two `|` separators; it extracts `origin`, `originalValue`,
   `newLabel`. Rows are bucketed into a raw-keyed map (origin contains `r`) or a display-keyed
   map (origin contains `d`).
3. For each `Result`, if `getRawValue()` is in the raw map it calls
   `setDisplayValue($newLabel)`; else if `getDisplayValue()` is in the display map it applies
   that. Only the **display value** is changed — raw value, count and query are untouched.

## Configuration form

`buildConfigurationForm()` renders a single **Replacement values** textarea
(`replacement_values`) with inline help describing the `r|…` and `d|…` syntax. That value is
validated by config schema `plugin.plugin_configuration.facets_processor.facets_custom_label`
(a `text` mapping key `replacement_values`).

## Implementing your own comparison

There is nothing to subclass here for normal use — to enable it, add the processor to a facet
(see [../configure/mapping.md](../configure/mapping.md)). If you needed different matching
logic you would write a separate `@FacetsProcessor` implementing `BuildProcessorInterface`,
not extend this one.
