#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal\editor\Entity\Editor::load("crt_medium")) { $e->delete(); }
  if ($f = \Drupal\filter\Entity\FilterFormat::load("crt_medium")) { $f->delete(); }
' >/dev/null 2>&1
echo "cleanup: crt_medium format+editor removed"
