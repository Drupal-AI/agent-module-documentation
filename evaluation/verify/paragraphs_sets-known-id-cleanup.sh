#!/usr/bin/env bash
# Introspection CLEANUP: delete the ps_named set. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs_sets\Entity\ParagraphsSet; if ($s = ParagraphsSet::load("ps_named")) { $s->delete(); }' >/dev/null 2>&1
echo "cleanup: paragraphs_set ps_named removed"
