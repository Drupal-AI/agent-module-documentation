#!/usr/bin/env bash
# Introspection SETUP: set cache_tag_header_name to a non-default value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("cloudfront_purger_tags.settings")->set("cache_tag_header_name", "X-CF-Cache-Tags")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cache_tag_header_name=X-CF-Cache-Tags"
