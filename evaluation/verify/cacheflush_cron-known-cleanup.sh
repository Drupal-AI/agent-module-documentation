#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfc_known"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "cleanup: cfc_known removed (its cron job deleted)"
