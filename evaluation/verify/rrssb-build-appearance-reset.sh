#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure button set rrssb_align does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\rrssb\Entity\RRSSBButtonSet; if ($s = RRSSBButtonSet::load("rrssb_align")) { $s->delete(); }' >/dev/null 2>&1
echo "reset: rrssb.button_set.rrssb_align removed"
