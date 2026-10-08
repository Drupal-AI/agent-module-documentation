#!/usr/bin/env bash
# Execution RESET: secret_note enabled=true, so verify FAILS until the agent disables it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("graphql_compose.settings")
    ->set("field_config.node.cfgql_eval.field_cfgql", [
      "enabled" => TRUE,
      "subfields" => [
        "secret_note" => ["enabled" => TRUE],
      ],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cfgql secret_note enabled=true"
