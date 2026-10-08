# entity_embed — agent start

Embeds any entity inside a CKEditor rich-text field via an **Embed button**; a text filter
(`EntityEmbedFilter`) renders the `<drupal-entity>` placeholder through an **Entity Embed
Display** plugin. Depends on core `editor`/`filter` + contrib `embed`. No standalone config
route — buttons live under **Admin → Config → Content authoring → Text editor embed buttons**.

- Create/scope embed buttons & enable the filter → [configure/embed-buttons.md](configure/embed-buttons.md)
- Entity Embed Display plugin type (implement a renderer) → [plugins/display.md](plugins/display.md)
- Alter hooks (filter plugins per context, alter build) → [hooks/hooks.md](hooks/hooks.md)
- Services & Twig embedding in code/templates → [api/services.md](api/services.md)
