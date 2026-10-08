#!/usr/bin/env bash
# Execution RESET: shipped defaults (empty protected_ids, protect_all off) so verify FAILS until
# the agent adds the contact form ID. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("protect_form_flood_control.settings");
  $c->setData([
    "general" => [
      "protect_all" => FALSE, "window" => 86400, "threshold" => 50,
      "protected_ids" => [], "unprotected_ids" => [], "whitelist" => ["127.0.0.1"], "log" => FALSE,
    ],
    "forms" => [], "show_ids" => FALSE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: protect_form_flood_control general.protected_ids=[] protect_all=false"
