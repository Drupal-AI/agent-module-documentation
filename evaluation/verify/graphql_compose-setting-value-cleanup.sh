#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default settings.expose_entity_ids = false.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("settings.expose_entity_ids", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: settings.expose_entity_ids=false (default)"
