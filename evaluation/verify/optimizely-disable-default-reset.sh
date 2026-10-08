#!/usr/bin/env bash
# Execution RESET: ensure the shipped 'default' sitewide project is ENABLED, so verify FAILS until
# the agent disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("optimizely")->load("default");
  if ($p) { $p->set("state", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: default project state=TRUE"
