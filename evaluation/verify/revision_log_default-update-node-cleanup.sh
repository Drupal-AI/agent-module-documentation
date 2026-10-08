#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["RLD Hard Update EDITED","RLD Hard Update"] as $t) {
    foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => $t]) as $e) { $e->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: RLD Hard Update nodes deleted"
