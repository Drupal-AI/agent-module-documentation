#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("facets_facet");
  if ($f = $s->load("salf_heatmap")) $f->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facet salf_heatmap removed"
