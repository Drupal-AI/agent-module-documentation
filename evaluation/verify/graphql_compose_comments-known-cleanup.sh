#!/usr/bin/env bash
# Introspection CLEANUP: clear entity_config.comment.comment.comments_mutation_enabled (restore baseline). No 'drush cr'.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server"); $c->clear("entity_config.comment.comment.comments_mutation_enabled")->save();' >/dev/null 2>&1
echo "cleanup: entity_config.comment.comment.comments_mutation_enabled cleared"
