#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfe_task"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "cleanup: cfe_task removed"
