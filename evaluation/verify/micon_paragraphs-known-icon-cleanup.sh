#!/usr/bin/env bash
# Introspection CLEANUP: delete paragraphs type micon_pg_med. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($t = \Drupal\paragraphs\Entity\ParagraphsType::load("micon_pg_med")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_pg_med removed"
