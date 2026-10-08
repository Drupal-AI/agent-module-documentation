#!/usr/bin/env bash
# Execution CLEANUP: restore shipped adv_varnish default. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("adv_varnish.cache_settings")->setData([
    "cache_control" => ["anonymous" => "/user/logout|must-revalidate, no-cache, private"],
  ])->save();
' >/dev/null 2>&1
echo "cleanup: adv_varnish.cache_settings restored to shipped default"
