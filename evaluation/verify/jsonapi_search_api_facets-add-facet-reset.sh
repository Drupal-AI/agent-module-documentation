#!/usr/bin/env bash
# Execution RESET: ensure NO facet jsaf_task exists, so verify FAILS until the agent creates
# a JSON:API facet. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\facets\Entity\Facet;
  if ($f = Facet::load("jsaf_task")) { $f->delete(); }
' >/dev/null 2>&1
echo "reset: facet jsaf_task absent"
