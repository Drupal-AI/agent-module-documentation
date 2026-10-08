# Expose Layout Paragraphs data

No settings form. Once enabled (with the paragraph types exposed in the GraphQL Compose config),
the schema gains the layout/position data for paragraphs arranged with Layout Paragraphs.

## What it resolves

- `LayoutParagraphs` — the layout applied to a layout-paragraph (which layout plugin + regions,
  resolved via `graphql_compose_layouts`).
- `LayoutParagraphsPosition` — where a child paragraph sits (its parent, region and order).
- `LayoutParagraphsInterface` — polymorphic access to layout-paragraph data.
- DataProducer `LayoutParagraphs` + `LayoutParagraphsSchemaExtension` wire it into the schema.

Layout Paragraphs stores placement as paragraph **behavior settings**; this submodule surfaces
that positional data alongside the Paragraph content already exposed by the parent module's
`Paragraph` entity type.

## Enable

1. Ensure `layout_paragraphs` and `graphql_compose_layouts` are enabled (dependencies).
2. Expose the relevant paragraph types (and the field that holds them) in the GraphQL Compose
   schema config (`entity_config.paragraph.<bundle>.enabled`, etc.).
3. Provider registration is automatic:

```bash
drush cget graphql.graphql_servers.graphql_compose_server schema_configuration.graphql_compose.providers
# expect graphql_compose_layout_paragraphs listed
```
