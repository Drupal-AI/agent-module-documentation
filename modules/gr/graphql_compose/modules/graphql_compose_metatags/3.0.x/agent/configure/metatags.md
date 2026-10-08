# Expose metatags

No dedicated settings form. Once enabled, the submodule automatically exposes the computed
`metatag` field on any entity type that has one — you enable the entity types themselves as
usual in the GraphQL Compose schema config.

## How it wires up

- `hook_graphql_compose_entity_base_fields_alter()` enables the entity's computed `metatag`
  base field (as multiple) on entity types that define one.
- `hook_graphql_compose_entity_interfaces_alter()` adds a `MetaTagInterface` to those types.
- `hook_graphql_compose_field_type_form_alter()` hides the metatag field from the GraphQL Compose
  field UI (it's a base field, so surfacing it in the UI would be confusing).

So for an enabled type (e.g. `entity_config.node.article.enabled = true`), the schema gains a
metatag field resolving to a list of `MetaTagUnion`.

## Query shape

```graphql
{ node { ... on Article { metatag { __typename
  ... on MetaTagValue { tag attributes { name content } }
  ... on MetaTagLink  { tag attributes { rel href } }
} } } }
```

## Schema types

- `MetaTag` (base), `MetaTagValue`, `MetaTagLink`, `MetaTagProperty`, `MetaTagScript`
  (each with a matching `*Attributes` type), `MetaTagUnion`, `MetaTagInterface`.
- FieldType `MetatagComputed`; extension `MetatagsSchemaExtension`.

## Extend the union

```php
function mymodule_graphql_compose_metatags_union_alter($value, ?string &$type): void {
  if ($value['tag'] === 'custom') { $type = 'MetatagCustom'; }
}
```

## Requirements

- `metatag` module. Metatag 2.x needs no patch; 1.x requires a patch (see the submodule README).
- Enabling this submodule registers it as a provider:
  `drush cget graphql.graphql_servers.graphql_compose_server schema_configuration.graphql_compose.providers`.
