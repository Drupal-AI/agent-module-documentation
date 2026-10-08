#!/usr/bin/env bash
# Introspection CLEANUP: delete the RUC Known node and the ruc_author user. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RUC Known"]) as $n) { $n->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "ruc_author"]) as $u) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: RUC Known node and ruc_author user removed"
