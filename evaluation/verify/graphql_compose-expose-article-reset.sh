#!/usr/bin/env bash
# Execution RESET: ensure node.article is NOT exposed (verify FAILS on empty state).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->clear("entity_config.node")->save();
' >/dev/null 2>&1
echo "reset: entity_config.node cleared (article not exposed)"
