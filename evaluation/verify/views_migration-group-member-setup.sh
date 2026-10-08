#!/usr/bin/env bash
# Introspection SETUP: add a known migration vm_known to the views_migration migration group
# (using the module's D7 source + entity:view destination), so an inspecting agent can list
# the group's migrations. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if (!Migration::load("vm_known")) {
    Migration::create([
      "id" => "vm_known", "label" => "VM Known Migration", "migration_group" => "views_migration",
      "source" => ["plugin" => "d7_views_migration"], "process" => ["id" => "name"],
      "destination" => ["plugin" => "entity:view"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migration vm_known added to group views_migration"
