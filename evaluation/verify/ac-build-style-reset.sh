#!/usr/bin/env bash
# Execution RESET: ensure image style ac_build does NOT exist, so verify FAILS until the agent
# builds it with an Automated Crop effect. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\image\Entity\ImageStyle; if ($s = ImageStyle::load("ac_build")) { $s->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: image style ac_build removed (absent)"
