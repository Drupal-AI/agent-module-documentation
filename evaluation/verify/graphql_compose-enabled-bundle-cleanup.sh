#!/usr/bin/env bash
# Introspection CLEANUP: remove node.article from GraphQL Compose config (baseline empty).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->clear("entity_config.node")->save();
' >/dev/null 2>&1
echo "cleanup: entity_config.node cleared"
