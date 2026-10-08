#!/usr/bin/env bash
# Execution RESET: clear entity_config.node.article.routes_enabled so verify FAILS on empty state. No 'drush cr'.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server"); $c->clear("entity_config.node.article.routes_enabled")->save();' >/dev/null 2>&1
echo "reset: entity_config.node.article.routes_enabled cleared"
