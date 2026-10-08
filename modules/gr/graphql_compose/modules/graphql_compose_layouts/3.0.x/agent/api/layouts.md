# Layout definitions in the schema

A low-level helper. It has no settings form and is `hidden: true`; it exposes Drupal's Layout
Discovery plugin definitions so higher-level submodules can describe sections.

## What it provides

- SchemaType `Layout` — a layout plugin definition (id, label, category, regions).
- FieldType `LayoutSectionItem` — resolves a `layout_section` field item.
- DataProducers:
  - `LayoutDefinitionLoad` — load a layout definition by id.
  - `LayoutDefinitionProperty` — read a property (label, regions, …) off a definition.
- `LayoutSchemaExtension` — wires the resolvers into the `graphql_compose` schema.

## How it's used

You rarely enable this alone. It is a dependency of:

- **graphql_compose_layout_builder** — resolves Layout Builder sections/components onto these layouts.
- **graphql_compose_layout_paragraphs** — resolves Layout Paragraphs layout data.

Enabling either of those pulls in `graphql_compose_layouts`.

## Requirements & registration

- Requires core `layout_discovery` (contrib layouts are discovered automatically).
- Enabling registers it as a schema provider:

```bash
drush cget graphql.graphql_servers.graphql_compose_server schema_configuration.graphql_compose.providers
# expect graphql_compose_layouts listed
```
