# Expose a view as a GraphQL query

Unlike the entity-type submodules, you don't toggle a bundle — you add a **GraphQL display** to
the view you want to expose.

## Add a GraphQL display

1. Edit the view (`/admin/structure/views/view/<view_id>`).
2. **Add** a new display and choose **GraphQL** (this submodule's display plugin).
3. Set the row style to **GraphQL entity** (`GraphQLEntityRow`) or **GraphQL fields**
   (`GraphQLFieldRow`), add any exposed filters, sorts and a pager.
4. Save. The view is now queryable through the schema; its exposed filters become GraphQL
   arguments and pagination is returned via `ViewPageInfo`.

The display settings validate against the submodule's config schema
(`config/schema/graphql_compose_views.views.schema.yml`).

## What it adds

- Views plugins (declared via the `GraphQLViewsDisplay` attribute): a `GraphQL` **display**,
  `GraphQL` **style**, row plugins `GraphQLEntityRow` / `GraphQLFieldRow`, and a `GraphQL`
  **exposed_form**; plus a `ViewsGraphQL` **search_api** display.
- SchemaTypes: `View`, `ViewFilter`, `ViewPageInfo`, `ViewReference`, `BetweenFloatInput`,
  `BetweenStringInput`.
- `ViewsSchemaExtension` + DataProducers: `ViewsExecutable*`, `ViewsEntityResults`,
  `ViewsFilters`, `ViewsPageInfo`, and (for viewfield) `ViewFieldItem*`, `ViewfieldContextualFilters`.

## Embed a referenced view (viewfield)

If `viewfield` is installed, enable a `viewfield` field to embed its referenced view:

```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server")
    ->set("field_config.node.<bundle>.<viewfield>.viewfield_query", TRUE)->save();
'
```

## Provider registration

Enabling the submodule registers it on each server:

```bash
drush cget graphql.graphql_servers.graphql_compose_server schema_configuration.graphql_compose.providers
# expect graphql_compose_views listed
```
