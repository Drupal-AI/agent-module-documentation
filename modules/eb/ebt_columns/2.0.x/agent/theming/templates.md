<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates, library & grid CSS

## Library

`ebt_columns.libraries.yml` declares one library:

```yaml
ebt_columns:
  css:
    component:
      css/styles.css: {}
```

No JS. Both templates call `{{ attach_library('ebt_columns/ebt_columns') }}`.

## Templates

- `templates/block--block-content--ebt-columns.html.twig` — reusable content block.
- `templates/block--inline-block--ebt-columns.html.twig` — Layout Builder inline block (identical
  except it adds a `block-revision-id-<id>` class instead of nothing).

Both build a `classes` array with fixed classes (`block`, `ebt-block`, `ebt-block-columns`,
`ebt-block-<plugin_id>`, `block-<provider>`, `block-<plugin_id>`, …) and then conditionally merge:

- `column-<layout>` when `content.field_ebt_settings['#object'].field_ebt_settings.ebt_settings.layout` is set;
- `columns-<column_width_two>` / `columns-<column_width_three>` / `columns-<column_width_four>` when each is set.

Markup:

```twig
<div{{ attributes.addClass(classes) }}>
  <div class="bg-inner"></div>
  <div class="ebt-container">
    {{ title_prefix }}
    {% if label %}<h2{{ title_attributes }}>{{ label }}</h2>{% endif %}
    {{ title_suffix }}
    {% block content %}{{ content|without('field_ebt_settings') }}{% endblock %}
  </div>
</div>
{{ styles|raw }}
```

- `content|without('field_ebt_settings')` renders everything **except** the settings field — so
  `field_ebt_columns_blocks` (the nested blocks) and `body` are output via their configured
  formatters; the block_field formatter renders each referenced block with its own access.
- `{{ styles|raw }}` is a `<style>` string produced by **ebt_core**'s `GenerateCSS` service
  (assigned to `variables['styles']` in ebt_core's block preprocess), not by this module.

## Grid CSS (`css/styles.css`)

Plain nested (PostCSS-style) rules under `.ebt-block-columns`. The nested-blocks field wrapper
`.field--name-field-ebt-columns-blocks` is set to `display: grid` with `grid-column-gap` and
`grid-row-gap` of `15px`; the `column-N` and `columns-X-Y` classes then set
`grid-template-columns`. Examples:

| Classes | `grid-template-columns` |
|---|---|
| `.column-2` | `1fr 1fr` |
| `.column-2.columns-33-67` | `1fr 2fr` |
| `.column-2.columns-75-25` | `3fr 1fr` |
| `.column-3.columns-25-50-25` | `1fr 2fr 1fr` |
| `.column-3.columns-25-25-50` | `1fr 1fr 2fr` |
| `.column-4.columns-40-20-20-20` | `2fr 1fr 1fr 1fr` |
| `.column-5` | `1fr 1fr 1fr 1fr 1fr` |
| `.column-6` | `1fr 1fr 1fr 1fr 1fr 1fr` |

The stylesheet uses native CSS nesting, so it needs a browser/Drupal build that supports it (no
Sass/PostCSS compilation step ships with the module).
