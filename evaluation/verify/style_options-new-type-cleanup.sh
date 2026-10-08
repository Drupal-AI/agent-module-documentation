#!/usr/bin/env bash
# Execution CLEANUP: delete so_build.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs\Entity\ParagraphsType; if ($pt = ParagraphsType::load("so_build")) { $pt->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: so_build removed"
