#!/usr/bin/env bash
# Introspection CLEANUP: restore empty description.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal\views\Entity\View::load("dashboard_last_content"); if($v){$v->set("description","")->save();}' >/dev/null 2>&1
echo "cleanup: view description cleared"
