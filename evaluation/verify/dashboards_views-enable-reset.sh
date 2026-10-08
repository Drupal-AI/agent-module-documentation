#!/usr/bin/env bash
# Execution RESET: DISABLE the dashboard_last_content view so verify FAILS until the agent re-enables it.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal\views\Entity\View::load("dashboard_last_content"); if($v){$v->setStatus(FALSE)->save();}' >/dev/null 2>&1
echo "reset: view dashboard_last_content disabled"
