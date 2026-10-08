#!/usr/bin/env bash
# Execution RESET: ensure monitoring_multigraph enabled and multigraph mg_task ABSENT (verify FAILS). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install monitoring_multigraph -y >/dev/null 2>&1
drush php:eval 'use Drupal\monitoring_multigraph\Entity\Multigraph; if ($m = Multigraph::load("mg_task")) { $m->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: monitoring_multigraph enabled; mg_task absent"
