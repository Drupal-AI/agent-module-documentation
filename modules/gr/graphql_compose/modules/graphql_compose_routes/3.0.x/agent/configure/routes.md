# Enable load-by-URL (routes)

No dedicated settings form. Enable route resolution per bundle through the GraphQL Compose
schema config; the `route(path:)` query then resolves that bundle's URLs.

## Enable routes for a bundle

Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.node.article.enabled", TRUE);        // expose the type
  $c->set("entity_config.node.article.routes_enabled", TRUE); // allow loading it by URL
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.node.article
```

The **Enable loading by route** checkbox is added by this submodule's
`hook_graphql_compose_entity_type_form_alter` (only for entity types with a `canonical` link
template) and stored at `routes_enabled`; the key is registered into the config schema via
`hook_config_schema_info_alter`.

## Query shape it enables

```graphql
{ route(path: "/about") { ... on RouteInternal { entity { __typename } } ... on RouteRedirect { url statusCode } } }
```

## What it adds / how to extend

- SchemaTypes: `Route`, `RouteInternal`, `RouteExternal`, `RouteRedirect`, `RouteUnion`, `RouteEntityUnion`.
- `RouteSchemaExtension` + DataProducers: `RoutePath`, `RouteLanguage`, `RouteEntityExtra`,
  `UrlOrRedirect`, `RedirectUrl`, `RedirectStatusCode`, `Breadcrumbs`; buffers `EntityPreviewBuffer`, `SubrequestBuffer`.
- Integrates with the `redirect` module (a `RouteRedirect` maps a Redirect entity).
- Rewrite incoming paths:

```php
function mymodule_graphql_compose_routes_incoming_alter(&$path, $context): void {
  if (preg_match('/^\/color/i', $path ?: '')) { $path = '/colour'; }
}
```

- Map custom values into the union with `hook_graphql_compose_routes_union_alter($value, ?string &$type)`.
