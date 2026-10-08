GraphQL Compose: Layout Builder (experimental) exposes core Layout Builder data — a field's sections, each section's layout and its placed components (including field/inline blocks) — to the GraphQL Compose schema so a decoupled front end can reconstruct the page layout.

---

This **experimental** submodule resolves a Layout Builder (`layout_builder`) field into structured GraphQL. It provides SchemaType plugins `LayoutBuilderSection`, `LayoutBuilderComponent`, `LayoutBuilderInterface`, `BlockField` and `BlockFieldUnion`, a `LayoutBuilderSchemaExtension`, a `LayoutBuilderSection` wrapper, and a large set of DataProducers that walk the layout: `LayoutBuilderSections`, `LayoutBuilderSectionComponents`, `LayoutBuilderSection{Id,Layout,Settings,Weight}`, `LayoutBuilderComponent{Id,Region,Weight,Configuration}`, `LayoutBuilderContexts`, `FieldBlockEntityLoad`, `SectionComponentFieldBlockLoad`, `LayoutBuilderBlockFieldName`. It depends on `graphql_compose_blocks` (to resolve block components) and `graphql_compose_layouts` (for the layout definitions/regions), plus core `layout_builder`. Because it is experimental it may change. Enabling it registers it as a schema provider (`schema_configuration.graphql_compose.providers.graphql_compose_layout_builder`); the layout data becomes available on entities whose bundle has a Layout Builder field exposed in the GraphQL Compose config.

---

- Expose a node's Layout Builder sections and components to a decoupled front end.
- Return each section's layout id and its regions so the client can rebuild the grid.
- Resolve placed blocks (field blocks, inline blocks) within Layout Builder sections.
- Get each component's region, weight and configuration for correct ordering.
- Reconstruct a Layout Builder page in a headless renderer.
- Query section settings (e.g. layout options) via `LayoutBuilderSectionSettings`.
- Resolve field blocks to their underlying entity field values (`FieldBlockEntityLoad`).
- Map Layout Builder components to front-end components 1:1.
- Combine with the Blocks submodule to render custom block content in sections.
- Use the shared Layouts submodule to know each layout's regions.
- Drive a decoupled page builder that mirrors Drupal Layout Builder.
- Return a `LayoutBuilderInterface` for polymorphic section/component handling.
- Expose per-component configuration for conditional rendering.
- Support experimental/evolving decoupled layout workflows.
- Keep visual layout authoring in Drupal while rendering it in the client.
- Resolve block field names within a section (`LayoutBuilderBlockFieldName`).
- Handle layout contexts (`LayoutBuilderContexts`) during resolution.
- Order sections and components deterministically by weight.
- Feed a static-site generator with full layout structure.
- Prototype headless Layout Builder rendering (noting the experimental status).
