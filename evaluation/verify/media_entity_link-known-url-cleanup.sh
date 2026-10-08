#!/usr/bin/env bash
# Introspection CLEANUP: delete the Known MEL Resource link media. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $st = \Drupal::entityTypeManager()->getStorage("media");
  foreach ($st->loadByProperties(["bundle" => "link", "name" => "Known MEL Resource"]) as $m) { $m->delete(); }
' >/dev/null 2>&1
echo "cleanup: Known MEL Resource link media removed"
