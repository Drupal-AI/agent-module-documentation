#!/usr/bin/env bash
# Introspection SETUP (cacheflush_drush): create a published preset 'cfd_known' (the kind `drush cf`
# would list). NOTE: the cacheflush_drush command is not runnable on this Drush version, so the agent
# inspects the cacheflush presets directly. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cfd_known"]) as $e){$e->delete();}
  $e=$s->create(["title"=>"cfd_known","status"=>1]); $e->setData(["render"=>["functions"=>[]]]); $e->save();
' >/dev/null 2>&1
echo "setup: published preset cfd_known created"
