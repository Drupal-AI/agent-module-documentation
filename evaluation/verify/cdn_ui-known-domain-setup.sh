#!/usr/bin/env bash
# Introspection SETUP: enable CDN and set domain cdn-ui-medium.example.com. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cdn.settings")
    ->set("status", TRUE)
    ->set("mapping", ["type"=>"simple","domain"=>"cdn-ui-medium.example.com","conditions"=>[]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cdn.settings domain=cdn-ui-medium.example.com"
