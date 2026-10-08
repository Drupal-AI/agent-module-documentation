# GraphQL Compose: Layouts — agent index

Hidden helper submodule (`hidden: true`) that exposes Drupal **layout definitions** (id, label,
regions) from Layout Discovery to the GraphQL Compose schema. It's the shared foundation the
Layout Builder and Layout Paragraphs submodules build on. Depends on `graphql_compose` +
`layout_discovery`. Usually enabled indirectly.

- **What it exposes (Layout type, definition producers) and how it's used** →
  [api/layouts.md](api/layouts.md)

Key facts:
- SchemaType `Layout`; FieldType `LayoutSectionItem`; DataProducers `LayoutDefinitionLoad`, `LayoutDefinitionProperty`; `LayoutSchemaExtension`.
- No settings form; `hidden: true` (not shown in the modules UI as a normal choice).
- Enabling registers it as a provider: `schema_configuration.graphql_compose.providers.graphql_compose_layouts`.
