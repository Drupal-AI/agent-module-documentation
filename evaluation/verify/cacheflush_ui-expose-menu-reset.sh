#!/usr/bin/env bash
# Execution RESET (cacheflush_ui): ensure a published preset 'cfu_task' exists but is NOT in the admin
# menu (menu=0), so verify FAILS until the agent exposes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cfu_task"]) as $e){$e->delete();}
  $e=$s->create(["title"=>"cfu_task","status"=>1,"menu"=>0]); $e->setData(["render"=>["functions"=>[]]]); $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cfu_task present, menu=0"
