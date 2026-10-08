#!/usr/bin/env bash
# Introspection SETUP (cacheflush_advanced): create preset 'cfa_known' whose advanced data invalidates
# the cache tag 'node_list', so an agent can inspect it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s=\Drupal::entityTypeManager()->getStorage("cacheflush");
  foreach($s->loadByProperties(["title"=>"cfa_known"]) as $e){$e->delete();}
  $e=$s->create(["title"=>"cfa_known","status"=>1]);
  $e->setData(["cache_tags"=>["functions"=>[["#name"=>"\\Drupal\\cacheflush\\Controller\\CacheflushApi::clearCacheTags","#params"=>["node_list"]]]]]);
  $e->save();
' >/dev/null 2>&1
echo "setup: preset cfa_known invalidates cache tag node_list"
