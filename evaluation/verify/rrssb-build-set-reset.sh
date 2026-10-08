#!/usr/bin/env bash
# Execution RESET/CLEANUP: ensure button set rrssb_task does NOT exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\rrssb\Entity\RRSSBButtonSet; if ($s = RRSSBButtonSet::load("rrssb_task")) { $s->delete(); }' >/dev/null 2>&1
echo "reset: rrssb.button_set.rrssb_task removed"
