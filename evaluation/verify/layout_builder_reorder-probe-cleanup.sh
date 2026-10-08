#!/usr/bin/env bash
# Introspection CLEANUP: delete the LBR Probe Node (leaves the namespaced lbr_reorder type).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"LBR Probe Node"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: LBR Probe Node removed"
