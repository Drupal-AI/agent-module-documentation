#!/usr/bin/env bash
# Introspection SETUP: create a live migrate_plus 'migration' config entity (mc_switch_test)
# whose process pipeline has a step 'category' that uses the migrate_conditions
# 'switch_on_condition' process plugin, so an agent can read the plugin id back from the live
# migration config (config API / drush cget) without needing the migration plugin manager.
# Written as raw config so no migration plugins are instantiated. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("migrate_plus.migration.mc_switch_test")->setData([
    "id" => "mc_switch_test", "label" => "MC Switch Test", "migration_group" => "default",
    "source" => ["plugin" => "embedded_data",
      "data_rows" => [["id" => 1, "kind" => "bird"], ["id" => 2, "kind" => "fish"]],
      "ids" => ["id" => ["type" => "integer"]]],
    "process" => ["category" => [
      "plugin" => "switch_on_condition", "source" => "kind", "cases" => []]],
    "destination" => ["plugin" => "null"],
  ])->save();
' >/dev/null 2>&1
echo "setup: migrate_plus.migration.mc_switch_test created (process.category uses switch_on_condition)"
