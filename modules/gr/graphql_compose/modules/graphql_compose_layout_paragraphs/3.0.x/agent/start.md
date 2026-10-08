# GraphQL Compose: Layout Paragraphs — agent index

Exposes Layout Paragraphs layout/position data (how paragraphs are arranged into layouts and
regions) to the GraphQL Compose schema. Depends on `graphql_compose`, `graphql_compose_layouts`
and `layout_paragraphs`. No settings form of its own.

- **What it resolves (layout, regions, positions) and the types/producer** →
  [configure/layout-paragraphs.md](configure/layout-paragraphs.md)

Key facts:
- SchemaTypes: `LayoutParagraphs`, `LayoutParagraphsInterface`, `LayoutParagraphsPosition`.
- DataProducer `LayoutParagraphs`; extension `LayoutParagraphsSchemaExtension`.
- Surfaces the layout placement stored as paragraph behavior settings, alongside the Paragraph
  entity type exposed by the parent module.
- Enabling registers it as a provider: `schema_configuration.graphql_compose.providers.graphql_compose_layout_paragraphs`.
