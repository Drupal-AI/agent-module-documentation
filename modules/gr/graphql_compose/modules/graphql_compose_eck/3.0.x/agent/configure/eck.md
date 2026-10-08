# Expose ECK entities

No dedicated settings form and no GraphQL types of its own. The submodule provides one
`eck` EntityType plugin whose deriver creates a GraphQL Compose entity type per ECK entity type.

## How it works

`src/Plugin/GraphQLCompose/EntityType/Eck.php`:

```php
#[EntityType(id: "eck", deriver: EckEntityTypeDeriver::class)]
class Eck extends GraphQLComposeEntityTypeBase {}
```

`EckEntityTypeDeriver` enumerates the site's ECK entity types and derives a plugin for each, so
they appear in the GraphQL Compose schema form alongside nodes/media.

## Enable an ECK bundle

Config object `graphql_compose.settings.graphql_compose_server`, same keys as any entity type:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.<eck_entity_type>.<bundle>.enabled", TRUE);
  $c->set("entity_config.<eck_entity_type>.<bundle>.query_load_enabled", TRUE); // optional single query
  $c->save();
'
```

Replace `<eck_entity_type>`/`<bundle>` with your ECK type and bundle machine names. (A site with
no ECK entity types defined will have nothing to enable here yet.)

## Provider registration

Enabling this submodule adds it to each GraphQL Compose server's provider list:

```bash
drush cget graphql.graphql_servers.graphql_compose_server schema_configuration.graphql_compose.providers
# expect graphql_compose_eck listed
```

Field selection, single/edge queries, translation and access all reuse the parent GraphQL
Compose machinery.
