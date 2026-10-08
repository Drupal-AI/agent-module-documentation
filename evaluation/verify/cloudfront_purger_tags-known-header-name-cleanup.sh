#!/usr/bin/env bash
# Introspection CLEANUP: restore default cache_tag_header_name 'Cache-Tags'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("cloudfront_purger_tags.settings")->set("cache_tag_header_name", "Cache-Tags")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cache_tag_header_name restored to Cache-Tags"
