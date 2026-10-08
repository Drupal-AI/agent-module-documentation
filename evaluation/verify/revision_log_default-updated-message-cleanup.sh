#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["RLD Known Update EDITED","RLD Known Update"] as $t) {
    foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $t]) as $e) { $e->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: RLD Known Update nodes deleted"
