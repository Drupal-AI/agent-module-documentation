#!/usr/bin/env bash
# Execution RESET: force protect_all OFF so verify FAILS until the agent enables it. Exit 0.
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
echo "reset: protect_form_flood_control general.protect_all=false"
