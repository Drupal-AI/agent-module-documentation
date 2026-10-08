# Configure the schema (enable types, fields, settings)

GraphQL Compose has **no module `configure` route**. You configure a specific GraphQL
**server** through tabs on its edit form. All state lives in one config object per server.

## Config object

Name: `graphql_compose.settings.<server_id>` — default
`graphql_compose.settings.graphql_compose_server`. Top-level keys:

```yaml
entity_config:            # which bundles are exposed
  <entity_type>:
    <bundle>:
      enabled: true             # expose this bundle as a GraphQL type
      query_load_enabled: true  # add a "load one by UUID" query (content entities)
      type_sdl: MyType          # (optional) override the GraphQL type name
      description: "…"          # (optional) override the type description
field_config:             # which fields are exposed
  <entity_type>:
    <bundle>:
      <field_name>:
        enabled: true
        required: true          # (optional) override required, if settings.field_required_override
        name_sdl: myField       # (optional) override the field's schema name
settings:                 # global schema toggles (see below)
  exclude_unpublished: true
  expose_entity_ids: false
  field_required_override: false
  schema_description: "GraphQL Compose"
  schema_version: "1"
  simple_queries: true
  simple_unions: true
  site_403: false
  site_404: false
  site_front: true
  site_mail: false
  site_name: false
  site_slogan: false
  inflector_langcode: en
  inflector_singularize: true
```

The GraphQL **server** entity is separate: `graphql.graphql_servers.<server_id>` holds
`endpoint` (`/graphql`), `schema: graphql_compose`, caching/batching flags, and
`schema_configuration.graphql_compose.providers` — the map of enabled GraphQL Compose
submodules (populated automatically as you enable submodules; see the module `.module`
`hook_modules_installed`).

## Admin UI (routes)

Tabs on the GraphQL server (`entity.graphql_server.edit_form`):

| Route | Path | Form |
|---|---|---|
| `graphql_compose.schema` | `…/manage/{graphql_server}/graphql_compose` | Enable entity types, bundles, fields |
| `graphql_compose.settings` | `…/graphql_compose/settings` | Global `settings.*` toggles |
| `graphql_compose.info` | `…/graphql_compose/info` | Read-only schema information |

Access is gated by the `_graphql_compose_access` check (there is no `permissions.yml`).

## Enable a bundle + field via drush (scriptable)

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.node.article.enabled", TRUE);
  $c->set("entity_config.node.article.query_load_enabled", TRUE);
  $c->set("field_config.node.article.body.enabled", TRUE);
  $c->save();
'
```

Read it back:

```bash
drush cget graphql_compose.settings.graphql_compose_server entity_config.node.article
drush cget graphql_compose.settings.graphql_compose_server settings
```

To disable a bundle, clear the key: `$c->clear("entity_config.node.article")->save();`
(baseline/install state is `entity_config: {}` and `field_config: {}`).

## Key global settings (`settings.*`)

- `exclude_unpublished` (bool) — hide unpublished entities from results.
- `expose_entity_ids` (bool) — expose internal integer IDs in addition to UUIDs.
- `field_required_override` (bool) — allow per-field `required` overrides in `field_config`.
- `simple_queries` / `simple_unions` (bool) — simpler generated query/union shapes.
- `site_name` / `site_slogan` / `site_mail` / `site_front` / `site_403` / `site_404` (bool) —
  expose those site-info values in the schema.
- `schema_description` / `schema_version` (string) — advertised to clients.
- `inflector_langcode` / `inflector_singularize` — control query-name pluralisation.

After changing config, GraphQL caches are flushed via `_graphql_compose_cache_flush()`
(the module clears the `graphql.*` and `graphql_compose.definitions` cache bins).
