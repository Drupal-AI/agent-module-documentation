#!/usr/bin/env bash
# Execution RESET: delete the 'LM Video Task' media item so verify FAILS on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Video Task"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
echo "reset: media item 'LM Video Task' removed"
