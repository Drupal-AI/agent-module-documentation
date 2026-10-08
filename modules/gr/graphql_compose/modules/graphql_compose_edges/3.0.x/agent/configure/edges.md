# Enable connection (edge) queries

No dedicated settings page beyond a per-bundle checkbox and one global number field on the
GraphQL Compose forms.

## Enable the connection query for a bundle

Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.node.article.enabled", TRUE);        // expose the type
  $c->set("entity_config.node.article.edges_enabled", TRUE);  // add the connection query
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.node.article
```

The **Enable edge query** checkbox is added by this submodule's
`hook_graphql_compose_entity_type_form_alter` for content entity types, and the key
`edges_enabled` is registered into the config schema via `hook_config_schema_info_alter`.

## Global max page size

```bash
drush php:eval '
  \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server")
    ->set("settings.edge_max_limit", 50)->save();
'
```

`settings.edge_max_limit` caps items returned per connection query (default
`EntityConnection::MAX_LIMIT`).

## What it adds / how to extend

- SchemaTypes: `ConnectionType`, `EdgeType`, `EdgeNode`, `ConnectionPageInfo`,
  `ConnectionSortKeys`, `CursorType`. Query shape: `edges { node cursor } pageInfo { … }`.
- DataProducers: `ConnectionEdges`, `ConnectionNodes`, `ConnectionPageInfo`, `EdgeCursor`,
  `EdgeNode`, `EntityTypePluginEdge`. Connection logic: `EntityConnection` + `EntityConnectionQueryHelper`.
- Built-in filters: `EntityFilterPublished`, `EntityFilterLanguage`.
- Extend a connection (custom filter, cache tags):

```php
function mymodule_graphql_compose_edges_alter($producer, $connection, $context): void {
  [$entity_type, $bundle] = explode(':', $producer->getDerivativeId());
  if ($entity_type === 'node' && $bundle === 'article') {
    $connection->setFilter('custom', TRUE, \Drupal\mymodule\CustomFilter::class);
    $context->addCacheTags(['my_thing']);
  }
}
```
