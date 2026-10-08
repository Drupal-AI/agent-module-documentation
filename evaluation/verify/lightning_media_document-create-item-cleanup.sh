#!/usr/bin/env bash
# Execution CLEANUP: delete the 'LM Document Task' media item.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Document Task"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
echo "cleanup: media item 'LM Document Task' removed"
