#!/usr/bin/env bash
# Introspection CLEANUP: delete button set rrssb_follow. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\rrssb\Entity\RRSSBButtonSet; if ($s = RRSSBButtonSet::load("rrssb_follow")) { $s->delete(); }' >/dev/null 2>&1
echo "cleanup: rrssb.button_set.rrssb_follow removed"
