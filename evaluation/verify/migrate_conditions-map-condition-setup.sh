#!/usr/bin/env bash
# Introspection SETUP: create a live migrate_plus 'migration' config entity (mc_map_test) whose
# process pipeline has a step 'found' that runs the migrate_conditions 'evaluate_condition'
# process plugin against the 'in_migrate_map' condition, so an agent can read the condition
# plugin id back from the live migration config (config API / drush cget) without needing the
# migration plugin manager. Written as raw config so no plugins are instantiated. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("migrate_plus.migration.mc_map_test")->setData([
    "id" => "mc_map_test", "label" => "MC Map Test", "migration_group" => "default",
    "source" => ["plugin" => "embedded_data",
      "data_rows" => [["id" => 1], ["id" => 2]],
      "ids" => ["id" => ["type" => "integer"]]],
    "process" => ["found" => [
      "plugin" => "evaluate_condition", "source" => "id",
      "condition" => ["plugin" => "in_migrate_map", "migration" => "mc_map_test"]]],
    "destination" => ["plugin" => "null"],
  ])->save();
' >/dev/null 2>&1
echo "setup: migrate_plus.migration.mc_map_test created (process.found evaluates in_migrate_map)"
