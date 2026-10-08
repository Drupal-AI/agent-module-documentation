#!/usr/bin/env bash
# Introspection CLEANUP: unregister graphql_compose_views provider (restore baseline). No 'drush cr'.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("graphql.graphql_servers.graphql_compose_server"); $c->clear("schema_configuration.graphql_compose.providers.graphql_compose_views")->save();' >/dev/null 2>&1
echo "cleanup: providers.graphql_compose_views cleared"
