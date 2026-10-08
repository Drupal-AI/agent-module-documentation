#!/usr/bin/env bash
# Introspection SETUP: create the migrate_plus migration_group config entity that a
# `drush migrate:upgrade --configure-only` run against a Drupal 7 source would generate,
# carrying its KNOWN label/source_type so an inspecting agent can read it back with drush.
# Entity id migrate_drupal_7 is not shipped by anything, so it is safe to create/delete.
# Idempotent: rewrites the entity each run. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\MigrationGroup;
  if ($g = MigrationGroup::load("migrate_drupal_7")) { $g->delete(); }
  MigrationGroup::create([
    "id" => "migrate_drupal_7",
    "label" => "Import from Drupal 7",
    "description" => "Migrations originally generated from drush migrate-upgrade --configure-only",
    "source_type" => "Drupal 7",
    "shared_configuration" => ["source" => ["key" => "drupal_7"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migration_group migrate_drupal_7 created (Import from Drupal 7)"
