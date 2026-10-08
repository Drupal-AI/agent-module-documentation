#!/usr/bin/env bash
# Execution RESET for "hide Authoring information + Promotion options on all node forms".
# Forces a clean WRONG baseline so verify FAILS until the agent configures Simplify: clears
# simplify.global:simplify_nodes_global to an empty array (nothing hidden) and simplify_admin
# to FALSE. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simplify.global")
    ->set("simplify_nodes_global", [])
    ->set("simplify_admin", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: simplify_nodes_global = [] (agent must hide author + options)"
