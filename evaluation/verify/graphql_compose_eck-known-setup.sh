#!/usr/bin/env bash
# Introspection SETUP: register graphql_compose_eck as a schema provider on the GraphQL Compose server. No 'drush cr'.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("graphql.graphql_servers.graphql_compose_server"); $c->set("schema_configuration.graphql_compose.providers.graphql_compose_eck", "graphql_compose_eck")->save();' >/dev/null 2>&1
echo "setup: providers.graphql_compose_eck registered"
