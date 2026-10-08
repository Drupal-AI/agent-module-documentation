# Twig filters

All filters take a **field render array** (as found in `content.field_name`). Defined in
`Drupal\twig_field_value\Twig\Extension\FieldValueExtension` (service
`twig_field_value.twig.extension`, tagged `twig.extension`).

| Filter | Returns |
|---|---|
| `field_label` | The field's label string. |
| `field_value` | Render array of the value(s) with the field wrappers removed (still renders, keeps cache metadata). |
| `field_raw` | Raw stored property value(s); pass a property name to get one property. |
| `field_target_entity` | The referenced entity object(s) of an entity-reference field. |

## Examples
```twig
{# Just the label #}
<h3>{{ content.field_foo|field_label }}</h3>

{# Value without the outer <div class="field ..."> wrappers #}
<div class="my-wrapper">{{ content.field_foo|field_value }}</div>

{# A single delta #}
{{ content.field_images.0|field_value }}

{# Raw property values #}
{{ content.field_link|field_raw('uri') }}     {# one named property #}
{{ content.field_text|field_raw }}            {# default 'value' property #}

{# Follow a reference and use the target entity's fields #}
{% set term = content.field_category|field_target_entity %}
{{ term.name.value }}
```

Notes:
- `field_value` preserves render caching and `#attached` assets; prefer it over `field_raw`
  when you still want Drupal to render the value.
- `field_raw` bypasses rendering and returns stored values — good for building attributes or
  strings, but you handle escaping/formatting yourself.
- On multi-value fields, filters operate over all deltas unless you target one (`.0`, `.1`…).
