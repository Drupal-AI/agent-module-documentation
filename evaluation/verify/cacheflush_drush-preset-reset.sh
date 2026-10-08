#!/usr/bin/env bash
# Execution RESET (cacheflush_drush): remove any cfd_task preset so verify FAILS until the agent
# creates a published preset that `drush cf <id>` could clear. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cfd_task"]) as $e){$e->delete();}' >/dev/null 2>&1
echo "reset: no cfd_task preset"
