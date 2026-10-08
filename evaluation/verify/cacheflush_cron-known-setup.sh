#!/usr/bin/env bash
# Introspection SETUP (cacheflush_cron): create a cron-enabled preset 'cfc_known' (which auto-creates
# an Ultimate Cron job cacheflush_preset_<id>), so an agent can inspect and name the job. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cfc_known"]) as $e){$e->delete();}
  $e=$s->create(["title"=>"cfc_known","status"=>1,"cron"=>1]); $e->setData(["render"=>["functions"=>[]]]); $e->save();
' >/dev/null 2>&1
echo "setup: cron-enabled preset cfc_known (Ultimate Cron job cacheflush_preset_<id> created)"
