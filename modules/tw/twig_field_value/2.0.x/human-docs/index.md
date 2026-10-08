# Twig Field Value — manual setup guide

**Twig Field Value** (`twig_field_value`) is a small themer's helper that adds four Twig filters for pulling exactly what you want out of a field — its label, its rendered value, a raw property, or the entity a reference points to — without dragging along Drupal's field markup wrappers. In a template, `content.field_foo` renders as a full render array wrapped in `<div class="field ...">` chrome; when you only want the bare value inside your own custom markup, digging it out of that render array is awkward. These filters do it for you.

The module ships four filters. `field_label` returns just the field's label text. `field_value` returns the render array of the value(s) with the field wrappers stripped off — it still renders correctly and keeps its cache metadata and attached assets, just without the surrounding div. `field_raw` returns the raw stored property value(s), or a single named property if you pass one. `field_target_entity` returns the referenced entity object(s) of an entity‑reference field, so you can drill into that entity's own fields. All of them accept a field render array (like `content.field_image`) and work on single‑ or multi‑value fields.

This is a pure library/theming module: it has **no settings page, no permissions, and no dependencies**. It works the moment you enable it — you simply start using the filters in your theme's Twig templates. There are no submodules.

This guide is written for a **human** editing Twig templates. If you want terse, token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it.

## How to use it

There is nothing to configure — once the module is enabled, the four filters are available in every Twig template. Each one takes a **field render array**, exactly as found in `content.field_name`.

| Filter | What it returns |
|---|---|
| `field_label` | The field's label string. |
| `field_value` | The value(s) render array with the field wrappers removed — still renders, and keeps cache metadata and `#attached` assets. |
| `field_raw` | The raw stored property value(s); pass a property name to get just one property. |
| `field_target_entity` | The referenced entity object(s) of an entity‑reference field. |

### Examples

```twig
{# Just the label #}
<h3>{{ content.field_foo|field_label }}</h3>

{# The value without the outer <div class="field ..."> wrappers #}
<div class="my-wrapper">{{ content.field_foo|field_value }}</div>

{# A single delta of a multi-value field #}
{{ content.field_images.0|field_value }}

{# Raw property values #}
{{ content.field_link|field_raw('uri') }}     {# one named property #}
{{ content.field_text|field_raw }}            {# the default 'value' property #}

{# Follow a reference and use the target entity's fields #}
{% set term = content.field_category|field_target_entity %}
{{ term.name.value }}
```

### Tips

- Prefer **`field_value`** over `field_raw` when you still want Drupal to render the value — it preserves render caching and `#attached` assets.
- **`field_raw`** bypasses rendering and hands you the stored values — great for building attributes or strings, but you are responsible for escaping and formatting.
- On multi‑value fields, the filters operate over all deltas unless you target one with `.0`, `.1`, and so on.
