#!/usr/bin/env bash
# Introspection CLEANUP: delete paragraph type so_known.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs\Entity\ParagraphsType; if ($pt = ParagraphsType::load("so_known")) { $pt->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: paragraph type so_known removed"
