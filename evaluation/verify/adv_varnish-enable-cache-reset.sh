#!/usr/bin/env bash
# Execution RESET: shipped default + force available.enable_cache FALSE so verify FAILS until on. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  
  \Drupal::configFactory()->getEditable("adv_varnish.cache_settings")->setData([
    "cache_control" => ["anonymous" => "/user/logout|must-revalidate, no-cache, private"],
  ])->save();

  \Drupal::configFactory()->getEditable("adv_varnish.cache_settings")->set("available.enable_cache",FALSE)->save();
' >/dev/null 2>&1
echo "reset: adv_varnish available.enable_cache=false"
