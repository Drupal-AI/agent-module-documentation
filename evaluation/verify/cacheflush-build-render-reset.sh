#!/usr/bin/env bash
# Execution RESET (cacheflush): remove any cf_task preset so verify FAILS until the agent creates a
# published preset that clears the render bin. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cf_task"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "reset: no cf_task preset"
