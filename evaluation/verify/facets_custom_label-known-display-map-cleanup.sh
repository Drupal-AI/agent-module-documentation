#!/usr/bin/env bash
# cleanup: facet fcl_map removed
set -uo pipefail
cd /var/www/html
drush php:eval '$f = \Drupal\facets\Entity\Facet::load("fcl_map"); if ($f) { $f->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facet fcl_map removed"
