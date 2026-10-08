#!/usr/bin/env bash
# Introspection SETUP: rename the dashboards_views-provided view (dashboard_last_content) to a marker.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal\views\Entity\View::load("dashboard_last_content"); if($v){$v->set("label","DV Probe Content List")->save();}' >/dev/null 2>&1
echo "setup: view dashboard_last_content label='DV Probe Content List'"
