#!/usr/bin/env bash
# Execution RESET: force settings.expose_entity_ids = FALSE (verify FAILS until agent sets TRUE).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("settings.expose_entity_ids", FALSE)->save();
' >/dev/null 2>&1
echo "reset: settings.expose_entity_ids=false"
