#!/usr/bin/env bash
# Introspection SETUP: create an ECA model ectamp_known containing one action that uses the
# eca_tamper 'convert_case' derivative (plugin eca_tamper:convert_case), so an agent can read
# back which Tamper plugin the model's action uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("eca");
  if ($e = $s->load("ectamp_known")) { $e->delete(); }
  $s->create([
    "id" => "ectamp_known", "label" => "ECA Tamper Known", "status" => TRUE,
    "events" => [], "conditions" => [], "gateways" => [],
    "actions" => [
      "act_case" => [
        "plugin" => "eca_tamper:convert_case",
        "label" => "Convert case",
        "configuration" => ["eca_data" => "[node:title]", "eca_token_name" => "cased"],
        "successors" => [],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eca model ectamp_known action plugin=eca_tamper:convert_case"
