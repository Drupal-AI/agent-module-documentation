#!/usr/bin/env bash
# Execution CLEANUP: delete the RUC Sample node and the ruc_from / ruc_target users. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RUC Sample"]) as $n) { $n->delete(); }
  foreach (["ruc_from","ruc_target"] as $name) {
    foreach (\Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => $name]) as $u) { $u->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: RUC Sample node and ruc_from/ruc_target users removed"
