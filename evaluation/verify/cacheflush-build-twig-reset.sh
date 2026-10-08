#!/usr/bin/env bash
# Execution RESET (cacheflush): remove any cf_task_twig preset so verify FAILS until the agent builds
# a published preset that wipes the Twig PHP storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cf_task_twig"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "reset: no cf_task_twig preset"
