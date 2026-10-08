#!/usr/bin/env bash
# Execution CLEANUP: delete the 'LM Audio Task' media item.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Audio Task"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
echo "cleanup: media item 'LM Audio Task' removed"
