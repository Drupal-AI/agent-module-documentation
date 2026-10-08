# Theming — how attributes render

## Render pipeline

1. **Event subscriber** `LayoutBuilderComponentRenderArray` (service
   `…section_component_build_render_array_subscriber`, tagged `event_subscriber`) listens on
   `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY`. In `onBuildRender()` it copies
   the component's stored `component_attributes` onto the block build as
   `$build['#component_attributes']`.
2. **`layout_builder_component_attributes_preprocess_block()`** (a
   `template_preprocess_block` implementation in the `.module` file) reads
   `$variables['elements']['#component_attributes']` and merges each group into the standard
   block Twig attribute variables:

| Stored group | Twig variable it feeds |
|---|---|
| `block_attributes` | `attributes` (block wrapper) |
| `block_title_attributes` | `title_attributes` |
| `block_content_attributes` | `content_attributes` |

For each group the preprocess applies only attributes that are **both** allowed in the global
config **and** non-empty on the component: `id` sets the id; `class` is space-split and
`array_merge`-d onto existing classes; `style` sets the style; `data` is split per line and
each `name|value` becomes an attribute (a line with no `|` value renders as a boolean attribute,
i.e. value `TRUE`).

## `content_attributes` theme requirement

Block content (inner) attributes only render if the active front-end theme's `block.html.twig`
actually outputs `content_attributes` on the inner element, e.g.:

```twig
<div{{ attributes.addClass(classes) }}>
  {{ title_prefix }}
  {% if label %}
    <h2{{ title_attributes }}>{{ label }}</h2>
  {% endif %}
  {{ title_suffix }}
  {% block content %}
    <div{{ content_attributes.addClass('content') }}>
      {{ content }}
    </div>
  {% endblock %}
</div>
```

Many core themes' `block.html.twig` do **not** print `content_attributes`; in that case
wrapper (`attributes`) and title (`title_attributes`) attributes still render, but content-group
attributes are silently dropped. A theme without its own `block.html.twig` inherits from its
parent/base theme. Wrapper and title attributes work with the standard block template.
