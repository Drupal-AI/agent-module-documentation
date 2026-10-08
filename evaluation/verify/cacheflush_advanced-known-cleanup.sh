#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfa_known"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "cleanup: cfa_known removed"
