#!/usr/bin/env bash
# Execution CLEANUP: restore the shipped default project to ENABLED (its shipped state). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("optimizely")->load("default");
  if ($p) { $p->set("state", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default project state restored to TRUE"
