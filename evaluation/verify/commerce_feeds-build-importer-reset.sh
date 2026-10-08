#!/usr/bin/env bash
# Execution RESET: ensure no cf_import feed type exists (so verify FAILS until built). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\feeds\Entity\FeedType; if ($ft = FeedType::load("cf_import")) { $ft->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: feeds.feed_type.cf_import absent"
