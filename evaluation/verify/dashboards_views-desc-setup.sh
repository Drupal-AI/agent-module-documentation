#!/usr/bin/env bash
# Introspection SETUP: set a marker description on the dashboard_last_content view.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal\views\Entity\View::load("dashboard_last_content"); if($v){$v->set("description","DV probe recent-nodes feed")->save();}' >/dev/null 2>&1
echo "setup: view dashboard_last_content description set"
