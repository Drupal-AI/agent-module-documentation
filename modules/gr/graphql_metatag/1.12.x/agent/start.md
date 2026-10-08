<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Metatag (graphql_metatag) — agent index

Exposes Metatag output through a **GraphQL 3.x** schema. No config, no permissions, no services,
no Drush — the whole module is GraphQL plugin classes plus three `define()`s.

> **Compatibility gate — read first.** `graphql_metatag.info.yml` depends on
> `graphql:graphql_core`, a submodule that exists only in **GraphQL 3.x**. The plugin classes use
> the 3.x annotation API (`@GraphQLField`, `@GraphQLType`, `@GraphQLInterface`, `@GraphQLScalar`,
> `FieldPluginBase::resolveValues()`), which GraphQL 4.x/5.x replaced with schema/data-producer
> plugins. On a site running `drupal/graphql` 4 or 5 this module **cannot be enabled** — there is
> no `graphql_core` to satisfy. The `^9 || ^10 || ^11` core constraint in info.yml does not
> change that. Documented from source for that reason.

- **The fields, types and interface it registers, and example queries** →
  [api/schema.md](api/schema.md)

Key facts:
- Fields: `entityMetatags` (`[Metatag]`, parent `Entity`), `entitySchemaMetatags` (`String`,
  parent `Entity`), `metatags` (`[Metatag]`, parents `InternalUrl` + `EntityCanonicalUrl`),
  plus `key` (`String`) and `value` (`MapArray`) on the `Metatag` interface. All are
  `secure = true`.
- Types implementing the `Metatag` interface, selected by `applies()` on the render array:
  `MetaValue` (`<meta>` without property/http-equiv/itemprop), `MetaProperty` (`property=`),
  `MetaHttpEquiv` (`http-equiv=`), `MetaItemProp` (`itemprop=`), `MetaLink` (`<link>`),
  `MetaLinkHreflang` (`<link hreflang=>`).
- Scalar `MapArray` (`@GraphQLScalar id = "map_array"`, typed data `map`) returns the tag's
  attribute array as-is rather than a string.
- `schema_metatag`-owned elements are filtered out of the plain tag lists (both resolvers check
  `#attributes.schema_metatag`); fetch them via `entitySchemaMetatags`, which returns JSON.
- `graphql_metatag.module` defines only three constants — `SCHEMA_METATAG_MODULE_NAME`,
  `EXTERNAL_HREFLANG_MODULE_NAME`, `METATAG_HREFLANG_MODULE_NAME` — and implements no hooks.
- CLI quirk: `EntityMetatags::changeRouteContext()` fires only when `PHP_SAPI === 'cli'`, pushing
  a synthetic `entity.node.canonical` request so route-dependent tags resolve; it hardcodes the
  `node` route parameter regardless of the entity type.
