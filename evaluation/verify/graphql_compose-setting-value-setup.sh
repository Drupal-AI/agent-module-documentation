#!/usr/bin/env bash
# Introspection SETUP: set the global toggle settings.expose_entity_ids = true.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("settings.expose_entity_ids", TRUE)->save();
' >/dev/null 2>&1
echo "setup: settings.expose_entity_ids=true"
