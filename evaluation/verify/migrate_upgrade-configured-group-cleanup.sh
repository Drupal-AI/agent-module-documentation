#!/usr/bin/env bash
# Introspection CLEANUP: remove the migrate_drupal_7 migration_group config entity added by
# the matching setup, restoring baseline (nothing ships it). Idempotent: no-op if gone. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\MigrationGroup;
  if ($g = MigrationGroup::load("migrate_drupal_7")) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: migration_group migrate_drupal_7 removed"
