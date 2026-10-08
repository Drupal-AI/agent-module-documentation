#!/usr/bin/env bash
# Execution RESET: shipped default (no varnish_server, purger off) so verify FAILS until set. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("adv_varnish.cache_settings")->setData([
    "cache_control" => ["anonymous" => "/user/logout|must-revalidate, no-cache, private"],
  ])->save();
' >/dev/null 2>&1
echo "reset: adv_varnish.cache_settings restored (no varnish_server, purger off)"
