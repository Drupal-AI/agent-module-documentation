#!/usr/bin/env bash
# Introspection SETUP: mark the secret_note subfield disabled in the GraphQL schema.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("graphql_compose.settings")
    ->set("field_config.node.cfgql_eval.field_cfgql", [
      "enabled" => TRUE,
      "subfields" => [
        "headline" => ["enabled" => TRUE],
        "secret_note" => ["enabled" => FALSE],
      ],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: graphql_compose.settings field_cfgql subfields.secret_note.enabled=false"
