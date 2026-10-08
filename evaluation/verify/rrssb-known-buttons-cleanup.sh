#!/usr/bin/env bash
# Introspection CLEANUP: delete button set rrssb_known. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\rrssb\Entity\RRSSBButtonSet; if ($s = RRSSBButtonSet::load("rrssb_known")) { $s->delete(); }' >/dev/null 2>&1
echo "cleanup: rrssb.button_set.rrssb_known removed"
