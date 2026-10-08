#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped view label.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal\views\Entity\View::load("dashboard_last_content"); if($v){$v->set("label","Dashboard: Last content")->save();}' >/dev/null 2>&1
echo "cleanup: view label restored to 'Dashboard: Last content'"
