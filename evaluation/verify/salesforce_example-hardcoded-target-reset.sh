#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($m=\Drupal::entityTypeManager()->getStorage("salesforce_mapping")->load("sfe_ttask")){$m->delete();}' >/dev/null 2>&1
echo "reset: mapping sfe_ttask absent"
