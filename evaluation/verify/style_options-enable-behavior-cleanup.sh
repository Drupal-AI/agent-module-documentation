#!/usr/bin/env bash
# Execution CLEANUP: delete so_task.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\paragraphs\Entity\ParagraphsType; if ($pt = ParagraphsType::load("so_task")) { $pt->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: so_task removed"
