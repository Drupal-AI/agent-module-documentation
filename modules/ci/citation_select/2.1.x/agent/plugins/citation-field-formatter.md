# The `CitationFieldFormatter` plugin type

Citation Select defines its own plugin type to convert a Drupal field value into the CSL-JSON shape needed
for a citation. One plugin is chosen **per node field by the field's type**; if no plugin matches the type,
the `default` plugin is used.

## Plugin type wiring

- Manager service: `plugin.manager.citation.field.formatter`
  (`CitationFieldFormatterPluginManager`, parent `default_plugin_manager`).
- Subdirectory: `src/Plugin/CitationFieldFormatter/`.
- Annotation: `@CitationFieldFormatter` (`Drupal\citation_select\Annotation\CitationFieldFormatter`) with one
  property: `field_type` (the Drupal field type this plugin handles, or `default`).
- Interface: `CitationFieldFormatterInterface` — `formatMultiple(Node $node, $node_field, array $csl_fields)`.
- Base class: `CitationFieldFormatterBase` (implements name/date/standard conversion).
- Alter hook: `hook_citation_select_info_alter` (cache tag `citation_select_info_plugins`).

`csl_fields` is a map of `csl_field => csl_type`, where `csl_type` is `person`, `date`, or `standard`
(decided by `CitationProcessorService::getCslType()`). The base class routes each: `person` →
`formatNames()` (uses the human name parser), `date` → `parseDate()` (`date_parse`), `standard` →
`getField()`.

## Built-in plugins

| id | `field_type` | Converts |
|---|---|---|
| `default` | `default` | Fallback. Standard string value; also handles pseudo-fields `title` (node title) and `current url` (absolute node URL). |
| `edtf` | `edtf` | EDTF date fields → CSL date-parts via `professional-wiki/edtf` (handles intervals; warns + returns empty parts on invalid input). |
| `entity_reference` | `entity_reference` | Referenced entity **label(s)** as the value. |
| `typed_relation` | `typed_relation` | Typed Relation field → filters by the CSL role using `typed_relation_map`, formatting names. |

## Name & date handling (base class)

- `formatNames()` → `convertName()` calls `citation_select.human_name_parser` (`adci/full-name-parser`) to
  split into `given`/`family`/`prefix`/`suffix`; if it can't parse (only one part or exception) it returns
  `{literal: <name>}`.
- `parseDate()` → `date_parse()` → `{date-parts: [[year, month, day]]}`.

## Implementing a custom formatter

```php
// src/Plugin/CitationFieldFormatter/MyTypeFormatter.php
namespace Drupal\my_module\Plugin\CitationFieldFormatter;

use Drupal\citation_select\CitationFieldFormatterBase;

/**
 * @CitationFieldFormatter(
 *   id = "my_type",
 *   field_type = "my_field_type",
 * )
 */
class MyTypeFormatter extends CitationFieldFormatterBase {
  // Override getField()/getFieldValueList()/parseDate() as needed, or
  // override formatMultiple() for full control. Return a CSL-JSON fragment
  // keyed by the requested csl_field(s).
  protected function getField($node, $field) {
    return (string) $node->get($field)->value; // your extraction
  }
}
```

The plugin is discovered automatically; it is selected whenever a mapped node field has
`field_type = my_field_type`. If a field's type has no matching plugin, `default` handles it.
