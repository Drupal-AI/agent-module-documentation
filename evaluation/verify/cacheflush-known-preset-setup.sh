#!/usr/bin/env bash
# Introspection SETUP (cacheflush): create a published preset 'cf_known' that clears the render bin,
# so an agent can inspect the cacheflush entities and report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach(\Drupal::entityTypeManager()->getStorage("cacheflush")->loadByProperties(["title"=>"cf_known"]) as $e){$e->delete();}
  $e=\Drupal::entityTypeManager()->getStorage("cacheflush")->create(["title"=>"cf_known","status"=>1]);
  $e->setData(["render"=>["functions"=>[["#name"=>"\\Drupal\\cacheflush\\Controller\\CacheflushApi::clearBinCache","#params"=>["cache.render"]]]]]);
  $e->save();
' >/dev/null 2>&1
echo "setup: published cacheflush preset cf_known (clears render bin)"
