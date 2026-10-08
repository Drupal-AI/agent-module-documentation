#!/usr/bin/env bash
# Execution CLEANUP: delete paragraphs type micon_pg_task. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($t = \Drupal\paragraphs\Entity\ParagraphsType::load("micon_pg_task")) { $t->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: micon_pg_task removed"
