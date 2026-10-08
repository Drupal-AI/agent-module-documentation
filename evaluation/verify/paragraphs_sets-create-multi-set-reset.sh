#!/usr/bin/env bash
# Execution RESET: ensure paragraphs_set ps_multi does NOT exist so verify FAILS until the
# agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs_sets\Entity\ParagraphsSet; if ($s = ParagraphsSet::load("ps_multi")) { $s->delete(); }' >/dev/null 2>&1
echo "reset: paragraphs_set ps_multi absent"
