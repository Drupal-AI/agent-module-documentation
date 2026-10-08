Twig Render This adds a single Twig filter, `renderThis`, that renders a Drupal entity, field item, or field item list to a render array from directly inside a Twig template, using a chosen view mode.

---

The module registers one Twig extension (`twig_render_this.twig_extension`) exposing the `|renderThis` filter. Given an entity, it builds the entity view via the entity type's view builder (`$view_builder->view($entity, $view_mode)`); given a `FieldItemInterface` / `FieldItemListInterface` (or any object with a `view()` method), it calls `->view($view_mode)`; anything else yields a "Twig Render This: Unsupported content." message. The filter takes one optional argument, the view mode (default `default`). It is aimed at themers who have an entity or field object available as a Twig variable (for example from a preprocess function, a reference field, or `content.field_x`) and want to render it with full Drupal rendering (formatters, view modes, cache metadata) rather than printing raw values. There is no configuration, no permissions, no services beyond the Twig extension. Because templates are authored by trusted theme developers, the choice of what to render — and any entity access considerations — rests with the template author.

---

- Render a referenced entity in a template with `{{ node.field_related.entity|renderThis }}`.
- Render an entity in a specific view mode: `{{ my_entity|renderThis('teaser') }}`.
- Render a whole field item list through its formatters from Twig.
- Render a single field item in a chosen display mode.
- Render a user entity as a formatted card inside a custom template.
- Render a media entity with its configured view mode from a component template.
- Render a taxonomy term entity inline in a node template.
- Render the entity behind an entity-reference field without a preprocess hook.
- Display a paragraph entity in a specific view mode from a parent template.
- Build reusable component templates that accept an entity variable and render it.
- Render entities passed into a Twig template by a custom render element.
- Avoid writing preprocess/`hook_theme` boilerplate just to render an entity.
- Render a block content entity in a template.
- Render a commerce/product-style entity via its view builder from Twig.
- Render an entity loaded in a Views field rewrite / template context.
- Render an entity in the `full` view mode to embed a full display in a wrapper.
- Combine with layout templates to place a rendered entity in a specific region.
- Render field output with cache metadata preserved (via the view builder), not raw text.
