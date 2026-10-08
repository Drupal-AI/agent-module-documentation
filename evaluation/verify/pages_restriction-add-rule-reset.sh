#!/usr/bin/env bash
# Execution RESET: clear pages_restriction mapping to empty so verify FAILs until the agent
# adds the required restricted|target rule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("pages_restriction.settings");
  $c->set("pages_restriction", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: pages_restriction mapping empty"
