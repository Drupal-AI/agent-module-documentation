GraphQL Compose: Layouts is a hidden helper submodule that exposes Drupal layout (Layout Discovery) definitions — a layout plugin's id, label and regions — to the GraphQL Compose schema, so consumers of Layout Builder or Layout Paragraphs can describe their sections.

---

This is a low-level, `hidden: true` submodule (it does not appear as a normal option in the modules UI) that adds layout-plugin metadata to the schema. It provides a `Layout` SchemaType, a `LayoutSectionItem` FieldType, DataProducers `LayoutDefinitionLoad` and `LayoutDefinitionProperty`, and a `LayoutSchemaExtension`, all resolving Drupal's Layout Discovery plugin definitions (the layouts registered by core/contrib, each with an id, label, category and regions). On its own it mainly exposes the layout catalog/definitions; it exists so that the Layout Builder and Layout Paragraphs submodules — both of which depend on it — can attach concrete section/component data to a layout. Requires core `layout_discovery`. Enabling it registers it as a schema provider (`schema_configuration.graphql_compose.providers.graphql_compose_layouts`). You normally enable it indirectly by enabling Layout Builder or Layout Paragraphs support.

---

- Expose the site's available layout definitions (id, label, regions) to a decoupled client.
- Let a front end know which regions a layout plugin provides (e.g. two-column, three-column).
- Underpin the Layout Builder submodule's section/component resolution.
- Underpin the Layout Paragraphs submodule's layout resolution.
- Resolve a layout definition's properties (`LayoutDefinitionProperty`).
- Load a layout definition by id (`LayoutDefinitionLoad`).
- Describe a `layout_section` field's structure via `LayoutSectionItem`.
- Provide the layout catalog so a client can map layouts to front-end grid components.
- Keep layout structure authored in Drupal and consumed over GraphQL.
- Support responsive layout rendering by exposing region names.
- Share one layout-definition schema across Layout Builder and Layout Paragraphs.
- Expose layout labels/categories for editor-facing decoupled tooling.
- Avoid duplicating Drupal's layout catalog in the front end.
- Enable layout-aware rendering in a headless page builder.
- Return region ids so components can be placed correctly client-side.
- Provide a stable `Layout` type reused by dependent submodules.
- Drive a component-per-region mapping in a decoupled theme.
- Support custom contrib layouts automatically (they're discovered).
- Feed a static-site generator with layout metadata.
- Act as the shared foundation for GraphQL Compose layout features.
