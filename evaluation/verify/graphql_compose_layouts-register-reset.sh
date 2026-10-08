#!/usr/bin/env bash
# Execution RESET: unregister graphql_compose_layouts provider so verify FAILS on empty state. No 'drush cr'.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("graphql.graphql_servers.graphql_compose_server"); $c->clear("schema_configuration.graphql_compose.providers.graphql_compose_layouts")->save();' >/dev/null 2>&1
echo "reset: providers.graphql_compose_layouts cleared"
