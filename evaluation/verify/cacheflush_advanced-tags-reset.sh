#!/usr/bin/env bash
# Execution RESET (cacheflush_advanced): remove any cfa_task preset so verify FAILS until the agent
# builds a preset that invalidates the node_list cache tag. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfa_task"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "reset: no cfa_task preset"
