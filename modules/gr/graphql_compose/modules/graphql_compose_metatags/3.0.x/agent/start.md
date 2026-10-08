# GraphQL Compose: Metatags — agent index

Exposes the Metatag module's computed meta tags on entities as a GraphQL `MetaTagUnion`
(+ `MetaTagInterface`), so clients can render the right `<head>` tags per page. Depends on
`graphql_compose` + `metatag`. No settings form of its own.

- **How the metatag field/interface are added, the union/schema types, the alter hook** →
  [configure/metatags.md](configure/metatags.md)

Key facts:
- Adds the computed `metatag` base field (multiple) to entities that have one via
  `hook_graphql_compose_entity_base_fields_alter`, and a `MetaTagInterface` via
  `hook_graphql_compose_entity_interfaces_alter`.
- SchemaTypes: `MetaTag`, `MetaTagValue`, `MetaTagLink`, `MetaTagProperty`, `MetaTagScript`
  (+ `*Attributes`), `MetaTagUnion`, `MetaTagInterface`. FieldType `MetatagComputed`.
- Extend the union: `hook_graphql_compose_metatags_union_alter($value, ?string &$type)`.
- Enabling registers it as a provider: `schema_configuration.graphql_compose.providers.graphql_compose_metatags`.
