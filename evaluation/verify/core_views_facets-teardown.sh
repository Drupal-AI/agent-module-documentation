#!/usr/bin/env bash
# Shared CLEANUP/teardown: delete the facet, facet source and view fixture. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  use Drupal\facets\Entity\Facet;
  use Drupal\facets\Entity\FacetSource;
  if ($f = Facet::load("cvf_eval_facet")) { $f->delete(); }
  if ($s = FacetSource::load("core_views_exposed_filter__cvf_eval_view__page_1")) { $s->delete(); }
  if ($v = View::load("cvf_eval_view")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cvf_eval_facet, facet source and cvf_eval_view removed"
