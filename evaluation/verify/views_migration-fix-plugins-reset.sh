#!/usr/bin/env bash
# Execution RESET: (re)create migration vm_fix with placeholder source/destination plugins
# (core 'empty' / 'null') that are NOT the views_migration plugins, so verify FAILS until the
# agent switches it to use d7_views_migration + entity:view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  if ($m = Migration::load("vm_fix")) { $m->delete(); }
  Migration::create([
    "id" => "vm_fix", "label" => "VM Fix", "migration_group" => "views_migration",
    "source" => ["plugin" => "empty"], "process" => ["id" => "name"],
    "destination" => ["plugin" => "null"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: migration vm_fix uses source=empty destination=null"
