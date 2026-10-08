#!/usr/bin/env bash
# Execution RESET (cacheflush_entity): remove any cfe_task entity so verify FAILS until the agent
# creates one via the cacheflush entity API. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfe_task"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "reset: no cfe_task entity"
