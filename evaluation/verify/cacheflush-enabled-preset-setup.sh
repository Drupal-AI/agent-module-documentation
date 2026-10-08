#!/usr/bin/env bash
# Introspection SETUP (cacheflush): create two presets - cf_on (published) and cf_off (disabled) -
# so an agent can report which one is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cf_on"]) as $e){$e->delete();}
  foreach($s->loadByProperties(["title"=>"cf_off"]) as $e){$e->delete();}
  $a=$s->create(["title"=>"cf_on","status"=>1]);  $a->setData(["render"=>["functions"=>[]]]); $a->save();
  $b=$s->create(["title"=>"cf_off","status"=>0]); $b->setData(["render"=>["functions"=>[]]]); $b->save();
' >/dev/null 2>&1
echo "setup: cf_on (status=1) and cf_off (status=0) presets created"
