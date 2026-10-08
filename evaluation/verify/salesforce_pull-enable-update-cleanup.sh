#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($m=\Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfl_task")){$m->delete();}' >/dev/null 2>&1
echo "cleanup: mapping sfl_task removed"
