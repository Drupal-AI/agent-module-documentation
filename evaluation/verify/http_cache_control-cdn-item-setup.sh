#!/usr/bin/env bash
# Introspection setup: configure a known targeted CDN-Cache-Control header.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("http_cache_control.settings")
    ->set("cache.targeted.items", [[
      "target"=>"CDN","max_age"=>3600,"no_cache"=>false,"must_revalidate"=>false,
      "no_store"=>false,"no_transform"=>false,"proxy_revalidate"=>false,"visibility"=>"public",
    ]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cache.targeted.items = [CDN public max-age=3600]"
