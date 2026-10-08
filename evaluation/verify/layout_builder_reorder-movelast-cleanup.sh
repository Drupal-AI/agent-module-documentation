#!/usr/bin/env bash
# Execution CLEANUP: delete the LBR Move Node. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Move Node"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: LBR Move Node removed"
