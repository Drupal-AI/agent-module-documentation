#!/usr/bin/env bash
# Execution RESET: ensure paragraph type so_build does NOT exist, so verify FAILS until the agent
# creates it AND enables the style_options behavior. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs\Entity\ParagraphsType; if ($pt = ParagraphsType::load("so_build")) { $pt->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraph type so_build absent"
