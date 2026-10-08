#!/usr/bin/env bash
# Execution CLEANUP: delete the media.document.default view display (baseline = absent).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.document.default");
  if ($d) { $d->delete(); }
' >/dev/null 2>&1
echo "cleanup: media.document.default view display deleted"
