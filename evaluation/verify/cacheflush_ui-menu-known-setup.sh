#!/usr/bin/env bash
# Introspection SETUP (cacheflush_ui): create a published preset 'cfu_menu' exposed in the admin menu
# (menu=1), so an agent can report which preset appears in the Cacheflush admin menu. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cfu_menu"]) as $e){$e->delete();}
  $e=$s->create(["title"=>"cfu_menu","status"=>1,"menu"=>1]); $e->setData(["render"=>["functions"=>[]]]); $e->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: published preset cfu_menu with menu=1 (admin-menu exposed)"
