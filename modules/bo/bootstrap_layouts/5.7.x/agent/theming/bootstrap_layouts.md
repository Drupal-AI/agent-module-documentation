# bootstrap_layouts — theming

## Templates

One Twig template per layout lives in `templates/3.0.0/` (e.g. `bs-1col.html.twig`,
`bs-2col.html.twig`, `bs-3col-stacked.html.twig`, `bs-4col-bricked.html.twig`). Each layout's
YAML `template:` key points at one (e.g. `templates/3.0.0/bs-2col`). To customize output, copy the
file into your theme and override it.

Every template renders a layout wrapper and one wrapper per non-empty region, for example:

```twig
<{{ wrapper }}{{ attributes }}>
  {{ title_suffix.contextual_links }}
  {% if left.content %}
  <{{ left.wrapper }}{{ left.attributes }}>
    {{ left.content }}
  </{{ left.wrapper }}>
  {% endif %}
  ...
</{{ wrapper }}>
```

Available variables:

- `wrapper` — the layout container element (from `layout.wrapper`, default `div`).
- `attributes` — a `Drupal\Core\Template\Attribute` object for the container.
- One variable per region (e.g. `left`, `right`, `top`, `main`, `first`…), each an array with
  `wrapper` (element name), `attributes` (`Attribute` object), and `content` (render array or NULL
  when the region is empty).

## How classes/attributes are generated

`_bootstrap_layouts_preprocess_layout()` (in `bootstrap_layouts.module`) builds these variables
from the saved settings, wrapping them in a `BootstrapLayout` value object:

- Container gets `layout.classes` (default `['row']`) plus, if `layout.add_layout_class` is on,
  the cleaned layout id (e.g. `bs-2col`).
- Each region gets its selected `classes` plus, if `add_region_classes` is on, `bs-region` and
  `bs-region--{region}`.
- `layout.attributes` and each region's `attributes` string is parsed by
  `_bootstrap_layouts_parse_attributes()` — comma-separated `key|value` pairs, run through the
  **Token** service and merged onto the `Attribute` object.
- When rendered through Display Suite, it also applies DS entity/view-mode classes and invokes
  `hook_ds_pre_render_alter()` (sets `rendered_by_ds = TRUE`).

`bootstrap_layouts_theme_registry_alter()` auto-registers this preprocess for every theme hook whose
layout plugin extends `BootstrapLayoutsBase`, so custom YAML layouts (see plugins doc) are handled
automatically. Styling relies on a Bootstrap-based theme providing `.row` / `.col-*` CSS.
