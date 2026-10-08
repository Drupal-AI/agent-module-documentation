#!/usr/bin/env bash
# Execution CLEANUP: delete the ps_multi set. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs_sets\Entity\ParagraphsSet; if ($s = ParagraphsSet::load("ps_multi")) { $s->delete(); }' >/dev/null 2>&1
echo "cleanup: paragraphs_set ps_multi removed"
