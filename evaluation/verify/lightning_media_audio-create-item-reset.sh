#!/usr/bin/env bash
# Execution RESET: delete the 'LM Audio Task' media item (and its fixture file) so verify
# FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Audio Task"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
echo "reset: media item 'LM Audio Task' removed"
