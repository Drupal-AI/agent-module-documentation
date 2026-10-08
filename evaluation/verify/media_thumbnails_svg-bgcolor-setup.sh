#!/usr/bin/env bash
# Introspection SETUP: enable a custom thumbnail background color #123456. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c=\Drupal::configFactory()->getEditable("media_thumbnails.settings");
  $c->set("bgcolor_active",TRUE)->set("bgcolor_value","#123456")->save();
' >/dev/null 2>&1
echo "setup: media_thumbnails.settings bgcolor_active=true bgcolor_value=#123456"
