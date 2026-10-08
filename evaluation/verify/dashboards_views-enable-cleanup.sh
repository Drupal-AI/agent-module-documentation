#!/usr/bin/env bash
# Execution CLEANUP: ensure the view is enabled (shipped default). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$v=\Drupal\views\Entity\View::load("dashboard_last_content"); if($v && !$v->status()){$v->setStatus(TRUE)->save();}' >/dev/null 2>&1
echo "cleanup: view dashboard_last_content enabled"
