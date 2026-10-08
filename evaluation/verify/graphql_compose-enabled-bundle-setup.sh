#!/usr/bin/env bash
# Introspection SETUP: expose node.article in GraphQL Compose config (enabled + single query).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.node.article.enabled", TRUE);
  $c->set("entity_config.node.article.query_load_enabled", TRUE);
  $c->save();
' >/dev/null 2>&1
echo "setup: entity_config.node.article enabled=true query_load_enabled=true"
