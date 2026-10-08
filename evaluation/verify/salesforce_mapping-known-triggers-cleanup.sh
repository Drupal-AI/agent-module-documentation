#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($m=\Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfm_trig")){$m->delete();}' >/dev/null 2>&1
echo "cleanup: mapping sfm_trig removed"
