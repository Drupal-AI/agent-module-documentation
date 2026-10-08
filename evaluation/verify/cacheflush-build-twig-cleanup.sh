#!/usr/bin/env bash
# Execution CLEANUP (cacheflush): remove cf_task_twig preset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cf_task_twig"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "cleanup: cf_task_twig removed"
