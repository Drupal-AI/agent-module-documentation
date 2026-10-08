#!/usr/bin/env bash
# Execution RESET: config where price_amount is enabled but has NO name_sdl, so verify FAILS
# until the agent sets name_sdl=priceAmount.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("graphql_compose.settings")
    ->set("field_config.node.cfgql_eval.field_cfgql", [
      "enabled" => TRUE,
      "subfields" => [
        "price_amount" => ["enabled" => TRUE],
      ],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_cfgql price_amount has no name_sdl"
