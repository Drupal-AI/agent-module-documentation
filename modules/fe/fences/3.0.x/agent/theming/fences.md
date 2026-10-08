<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fences theming — the field template override

Fences works by **replacing core's `field.html.twig`** with its own copy
(`templates/field.html.twig`) via `hook_theme_registry_alter()`
(`fences_theme_registry_alter`). By default it only swaps in its template when the active
field template came from core (path starts with `core`); set
`fences.settings:fences_field_template_override_all_themes = true` to force it even when a
theme ships its own `field.html.twig`. A theme that needs custom field markup should provide
its own template rather than fight Fences.

## Preprocess variables

`fences_preprocess_field()` reads the field's stored `#third_party_settings['fences']` and
sets the variables the template consumes:

| Variable | Meaning |
|---|---|
| `display_field_tag` | render the field wrapper? (`false` when `fences_field_tag` = `none`) |
| `display_label_tag` | render the label wrapper? |
| `display_items_wrapper_tag` | render an items wrapper? (only when its tag is set and ≠ `none`) |
| `display_item_tag` | render each item wrapper? |
| `field_tag` / `label_tag` / `field_item_tag` / `field_items_wrapper_tag` | the chosen tag names |
| `field_items_wrapper_attributes` | `Attribute` object carrying the items-wrapper classes |

Classes from the four `*_classes` settings are pushed onto `attributes` (field),
`title_attributes` (label), each item's `attributes`, and `field_items_wrapper_attributes`.
When no Fences settings are present the defaults are: field tag on, label tag on, item tag on,
items-wrapper **off** — i.e. core-equivalent `<div>` output.

## The template shape

`templates/field.html.twig` wraps each region only when its `display_*_tag` is true, e.g.:

```twig
{%- if display_field_tag ~%}
  <{{ field_tag|default('div') }}{{ attributes.addClass(classes) }}>
{%- endif -%}
```

and likewise for the label (`label_tag`), the optional items wrapper
(`field_items_wrapper_tag`, given the `field__items` class), and each item (`field_item_tag`,
given the `field__item` class). When a tag resolves to `none` the corresponding
`display_*_tag` is false and the element is omitted, leaving just the inner content. The
standard core field classes (`field`, `field--name-…`, `field--type-…`, `field--label-…`) are
still applied to whatever field tag is emitted, so existing CSS keeps working.

## Adding new selectable tags

The tags offered in the dropdowns are **not** hardcoded in the template — they come from the
`*.fences.yml` registry. See [../plugins/tags.md](../plugins/tags.md).
