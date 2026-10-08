#!/usr/bin/env bash
# Introspection SETUP (cacheflush_entity): create a cacheflush entity 'cfe_known' so an agent can load
# it via the entity API/helpers and report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cfe_known"]) as $e){$e->delete();}
  $e=$s->create(["title"=>"cfe_known","status"=>1]); $e->setData(["render"=>["functions"=>[]]]); $e->save();
' >/dev/null 2>&1
echo "setup: cacheflush entity cfe_known created"
