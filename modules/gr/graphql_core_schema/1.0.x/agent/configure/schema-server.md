# Configuring the core_composable schema

There is **no settings route in this module**. You configure it through the GraphQL module's Server
entity.

## Steps

1. Enable this module (and any sub-modules whose extensions you want). Depends on `graphql:graphql`
   (^4 || ^5).
2. Go to `/admin/config/graphql` → **Add server** (or edit one).
3. In **Schema**, select **"Core Composable Schema"** (`core_composable`).
4. Set an endpoint path (e.g. `/graphql`) and the GraphQL module's server options.
5. Enable the **Schema extensions** you need (see
   [../extend/extensions-and-submodules.md](../extend/extensions-and-submodules.md)).
6. Enable the **Views** you want exposed (Views extension).
7. Choose the **entity types** to expose and the **fields** per type.
8. Save.

Endpoint access itself is governed by the **GraphQL module** (its per-server permissions like
"execute … arbitrary graphql requests", or persisted queries) — not by this module.

## Where config is stored

On the `graphql.server.<id>` config entity, key `schema_configuration.core_composable`. The module's
`hook_graphql_server_presave` cleans/sorts it. Notable sub-keys:

- `enabled_entity_types` — array of entity type ids to generate types for.
- `fields` — per entity type, the enabled fields (only enabled fields are exposed).
- `entity_base_fields.fields` — base fields to include.
- `extensions` — enabled schema extension plugin ids (array, filtered to truthy).
- `extension_views.enabled_views` — views exposed through the Views extension.

`graphql_core_schema_form_graphql_server_validate` also forces the server's `debug_flag` to FALSE on
save.

## Config schema

`graphql.schema.core_composable` declares the `core_composable` mapping as an opaque (`type: ignore`)
value — the structure above is managed by the schema plugin's form
(`Form/CoreComposableSchemaFormHelper`, `CoreComposableConfig`), not by config schema.

## Production tip

Disable the GraphQL 4 module's **development mode** in production: the schema and extensions are then
cached, a large performance win. Re-enable it only while actively editing the schema.
