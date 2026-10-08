#!/usr/bin/env bash
# Introspection CLEANUP: remove the cf_med feed type. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\feeds\Entity\FeedType; if ($ft = FeedType::load("cf_med")) { $ft->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: feeds.feed_type.cf_med removed"
