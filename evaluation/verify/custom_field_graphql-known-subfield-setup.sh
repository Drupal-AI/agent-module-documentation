#!/usr/bin/env bash
# Introspection SETUP: write a GraphQL Compose custom-field config with price_amount renamed to
# priceAmount. NOTE: graphql_compose is not installed on this site, so baseline = config absent;
# on a real graphql_compose site, clear only the subfields path instead of deleting the object.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("graphql_compose.settings")
    ->set("field_config.node.cfgql_eval.field_cfgql", [
      "enabled" => TRUE,
      "subfields" => [
        "headline" => ["enabled" => TRUE],
        "price_amount" => ["enabled" => TRUE, "name_sdl" => "priceAmount"],
      ],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: graphql_compose.settings field_cfgql subfields.price_amount.name_sdl=priceAmount"
