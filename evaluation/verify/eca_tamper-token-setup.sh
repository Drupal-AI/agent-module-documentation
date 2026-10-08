#!/usr/bin/env bash
# Introspection SETUP: create an ECA model ectamp_tok with an eca_tamper:trim action whose
# result token name (eca_token_name) is 'cleaned_value', so the agent must inspect the model
# to report the token name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  if ($e = $s->load("ectamp_tok")) { $e->delete(); }
  $s->create([
    "id" => "ectamp_tok", "label" => "ECA Tamper Token", "status" => TRUE,
    "events" => [], "conditions" => [], "gateways" => [],
    "actions" => [
      "act_trim" => [
        "plugin" => "eca_tamper:trim",
        "label" => "Trim value",
        "configuration" => ["eca_data" => "  [node:title]  ", "eca_token_name" => "cleaned_value"],
        "successors" => [],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eca model ectamp_tok trim action eca_token_name=cleaned_value"
