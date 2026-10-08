#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'if($a=\Drupal::entityTypeManager()->getStorage("salesforce_auth")->load("sfj_ltask")){$a->delete();}' >/dev/null 2>&1
echo "cleanup: salesforce_auth sfj_ltask removed"
