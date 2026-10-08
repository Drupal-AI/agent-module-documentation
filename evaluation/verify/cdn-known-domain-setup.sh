#!/usr/bin/env bash
# Introspection SETUP: enable CDN and serve all files from cdn-medium.example.com. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("cdn.settings");
  $c->set("status", TRUE)
    ->set("mapping", ["type"=>"simple","domain"=>"cdn-medium.example.com","conditions"=>[]])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cdn.settings status=true domain=cdn-medium.example.com"
