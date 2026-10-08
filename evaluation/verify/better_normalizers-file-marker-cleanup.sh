#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["filename" => "bnrm-eval-marker.txt"]) as $f) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: bnrm-eval-marker.txt removed"
