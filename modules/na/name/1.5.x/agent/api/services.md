<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: formatting names in code

Public services (see `name.services.yml`). Prefer these over touching field internals.

## `name.formatter` — `NameFormatterInterface`
High-level formatting with fallback to the `default` format.
```php
$f = \Drupal::service('name.formatter');
$components = [
  'title' => 'Mr.', 'given' => 'John', 'middle' => 'Peter',
  'family' => 'Smith', 'generational' => 'Jr.', 'credentials' => 'PhD',
];
$f->format($components, 'default');   // "Mr. John Peter Smith Jr., PhD"
$f->format($components, 'family');    // "Smith"
$f->format($components, 'given');     // "John"
```
- `format(array $components, $type = 'default', $langcode = NULL)` — `$type` is a
  `name_format` entity id; returns a `MarkupInterface`.
- `formatList(array $items, $type = 'default', $list_type = 'default', $langcode = NULL)` —
  join several name arrays into a list using a `name_list_format` id.
- `getLastDelimiterTypes()`, `getLastDelimiterBehaviors()` — option lists for list joins.
  (The `…Delimitor…` spellings are deprecated aliases.)

## `name.format_parser` — `NameFormatParserInterface`
Lower-level: parse a component array against an **arbitrary pattern string** (no entity, no
fallback).
```php
$p = \Drupal::service('name.format_parser');
$p->parse($components, 'f, g');       // "Smith, John"
$p->tokenHelp();                       // token letter -> description map
$p->getMarkupOptions();                // none/raw/simple/microdata/rdfa
```
`parse(array $name_components, string $format = '', array $settings = [])` — `$settings` may
carry `sep1/sep2/sep3/markup`.

## `name.generator` — `GeneratorInterface`
`generateSampleNames($count, $field_definition)` produces realistic sample component arrays
(used by the field type's `generateSampleValue()` and Devel).

## Other services
`name.options_provider`, `name.autocomplete` (autocomplete route
`/name/autocomplete/{field_name}/{entity_type}/{bundle}/{component}`), `name.widget_layouts`
(see [hooks/widget-layouts.md](../hooks/widget-layouts.md)), `name.format_options`,
`name.user_realname_preload`, `name.component_metadata`, `name.element_validator`. Interfaces
are aliased in `name.services.yml` for autowiring/type-hinting.
