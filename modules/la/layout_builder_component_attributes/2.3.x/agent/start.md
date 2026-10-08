# layout_builder_component_attributes — agent start

Adds a **Manage attributes** contextual link to each Layout Builder component (block), letting
editors set HTML attributes (id, class, style, data-*) on three parts of the rendered block:
the wrapper (`attributes`), the title (`title_attributes`), and the content
(`content_attributes`). Values are stored on the component's `component_attributes` setting and
merged into the block via `template_preprocess_block`. Depends only on core `layout_builder`.
Global settings route: `layout_builder_component_attributes.settings`
(`/admin/config/content/layout-builder-component-attributes`).

- Global settings + the per-component attributes form → [configure/layout_builder_component_attributes.md](configure/layout_builder_component_attributes.md)
- Permissions (settings vs. managing attributes) → [permissions/layout_builder_component_attributes.md](permissions/layout_builder_component_attributes.md)
- How attributes render + the `content_attributes` theme requirement → [theming/layout_builder_component_attributes.md](theming/layout_builder_component_attributes.md)
