#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($a=\Drupal::entityTypeManager()->getStorage("salesforce_auth")->load("sfj_task")){$a->delete();}' >/dev/null 2>&1
echo "reset: salesforce_auth sfj_task absent"
