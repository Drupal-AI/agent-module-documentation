#!/usr/bin/env bash
# Execution RESET: ensure a clean slate before the "build the configure-only migration group"
# task by deleting the migrate_drupal_7 migration_group config entity if present. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\MigrationGroup;
  if ($g = MigrationGroup::load("migrate_drupal_7")) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration_group migrate_drupal_7 cleared"
