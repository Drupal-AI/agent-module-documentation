GraphQL Compose: Layout Paragraphs exposes the layout information created with the Layout Paragraphs module — how paragraphs are arranged into layouts and regions — to the GraphQL Compose schema, so a decoupled front end can render nested paragraph layouts.

---

This submodule adds Layout Paragraphs (`layout_paragraphs`) layout data to the GraphQL schema. It provides SchemaType plugins `LayoutParagraphs`, `LayoutParagraphsInterface` and `LayoutParagraphsPosition`, a `LayoutParagraphs` DataProducer, and a `LayoutParagraphsSchemaExtension`. Layout Paragraphs stores each paragraph's layout/region placement as behavior settings; this submodule surfaces that positional data (which layout a paragraph uses, and where child paragraphs sit within its regions) alongside the paragraph content already exposed by GraphQL Compose's Paragraph entity type. It depends on `graphql_compose_layouts` (for the layout definitions/regions) and core/contrib `layout_paragraphs`. Enabling it registers it as a schema provider (`schema_configuration.graphql_compose.providers.graphql_compose_layout_paragraphs`); the layout data appears on paragraph types exposed in the GraphQL Compose config that use Layout Paragraphs.

---

- Expose a Layout Paragraphs field's nested layout structure to a decoupled front end.
- Return which layout each layout-paragraph uses and its regions.
- Get the position of child paragraphs within a layout's regions (`LayoutParagraphsPosition`).
- Reconstruct a paragraph-based page layout in a headless renderer.
- Combine paragraph content with its layout placement in one query.
- Map layout-paragraph layouts to front-end grid components.
- Use the shared Layouts submodule to resolve region names.
- Keep flexible content authoring in Layout Paragraphs while rendering it client-side.
- Support nested/section paragraphs in a decoupled UI.
- Query layout paragraphs polymorphically via `LayoutParagraphsInterface`.
- Drive a component library from Drupal layout-paragraph structures.
- Render multi-column paragraph layouts in Next.js/Nuxt.
- Order child paragraphs correctly using their positional data.
- Provide editors a Drupal layout experience with headless output.
- Feed a static-site generator with paragraph layout structure.
- Expose custom layouts used by Layout Paragraphs (discovered via Layouts).
- Localize layout-paragraph content for multilingual sites.
- Combine with Blocks/Media types for rich paragraph components.
- Build landing pages authored with Layout Paragraphs and consumed over GraphQL.
- Avoid re-implementing paragraph layout logic in the front end.
