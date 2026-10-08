#!/usr/bin/env bash
# Introspection SETUP: set entity_config.node.article.routes_enabled = true on the GraphQL Compose server config. Idempotent. No 'drush cr'.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server"); $c->set("entity_config.node.article.routes_enabled", TRUE)->save();' >/dev/null 2>&1
echo "setup: entity_config.node.article.routes_enabled=true"
