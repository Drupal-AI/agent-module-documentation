# GraphQL Compose: Layout Builder — agent index

**Experimental.** Exposes core Layout Builder data (a field's sections → each section's layout →
placed components/blocks) to the GraphQL Compose schema. Depends on `graphql_compose`,
`graphql_compose_blocks`, `graphql_compose_layouts` and core `layout_builder`. No settings form.

- **What it resolves (sections, components, field blocks) and the producers/types** →
  [configure/layout-builder.md](configure/layout-builder.md)

Key facts:
- SchemaTypes: `LayoutBuilderSection`, `LayoutBuilderComponent`, `LayoutBuilderInterface`, `BlockField`, `BlockFieldUnion`.
- Producers walk the layout: `LayoutBuilderSections`, `LayoutBuilderSectionComponents`,
  `LayoutBuilderSection{Id,Layout,Settings,Weight}`, `LayoutBuilderComponent{Id,Region,Weight,Configuration}`,
  `FieldBlockEntityLoad`, `SectionComponentFieldBlockLoad`.
- Enabling registers it as a provider: `schema_configuration.graphql_compose.providers.graphql_compose_layout_builder`.
- Layout data appears on entities whose bundle has an exposed Layout Builder field.
