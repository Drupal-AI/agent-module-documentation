#!/usr/bin/env bash
# Introspection SETUP: create a known migration vm_inspect (label 'VM Inspect Me') in the
# views_migration group using the module's Drupal 6 source plugin, so an inspecting agent can
# read its source plugin / label. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if (!Migration::load("vm_inspect")) {
    Migration::create([
      "id" => "vm_inspect", "label" => "VM Inspect Me", "migration_group" => "views_migration",
      "source" => ["plugin" => "d6_views_migration"], "process" => ["id" => "name"],
      "destination" => ["plugin" => "entity:view"],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: migration vm_inspect (label 'VM Inspect Me', source d6_views_migration) created"
