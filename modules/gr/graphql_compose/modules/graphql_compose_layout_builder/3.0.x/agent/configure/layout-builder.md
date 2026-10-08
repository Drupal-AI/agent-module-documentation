# Expose Layout Builder data

Experimental submodule; no settings form. Once enabled (and the entity's Layout Builder field
exposed via the GraphQL Compose config), the schema gains structured layout data.

## What it resolves

For an entity with a Layout Builder field, it exposes the layout hierarchy:

- **Sections** (`LayoutBuilderSection`): via `LayoutBuilderSections`; each has an id, a **layout**
  (from the Layouts submodule), settings and weight (`LayoutBuilderSectionId/Layout/Settings/Weight`).
- **Components** (`LayoutBuilderComponent`) in each section: via `LayoutBuilderSectionComponents`;
  each has an id, region, weight and configuration
  (`LayoutBuilderComponentId/Region/Weight/Configuration`).
- **Block components**: field blocks and inline blocks resolve through `graphql_compose_blocks`
  (`FieldBlockEntityLoad`, `SectionComponentFieldBlockLoad`, `LayoutBuilderBlockFieldName`);
  `BlockField` / `BlockFieldUnion` type them.
- `LayoutBuilderInterface` provides polymorphic access; `LayoutBuilderContexts` supplies context.

## Enable

1. Ensure `layout_builder`, `graphql_compose_blocks` and `graphql_compose_layouts` are enabled
   (dependencies).
2. Expose the bundle and its Layout Builder field in the GraphQL Compose schema config
   (`entity_config.<type>.<bundle>.enabled`, and enable the layout field in `field_config`).
3. Provider registration is automatic:

```bash
drush cget graphql.graphql_servers.graphql_compose_server schema_configuration.graphql_compose.providers
# expect graphql_compose_layout_builder listed
```

## Note

This module is flagged **experimental** (package "GraphQL Compose (Experimental)") and its schema
may change between releases.
