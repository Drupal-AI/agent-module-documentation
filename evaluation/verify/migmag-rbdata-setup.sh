#!/usr/bin/env bash
# Introspection SETUP: insert a known row into the migmag_rollbackable_data table so an agent can
# read it back. Requires migmag_rollbackable enabled (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("migmag_rollbackable_data")->condition("migration_plugin_id", "migmag_eval_probe")->execute();
  $db->insert("migmag_rollbackable_data")->fields([
    "migration_plugin_id" => "migmag_eval_probe",
    "target_id" => "system.site",
    "langcode" => "",
    "component" => "",
    "rollback_data" => serialize(["name" => "OLD SITE NAME"]),
  ])->execute();
' >/dev/null 2>&1
echo "setup: migmag_rollbackable_data row migration_plugin_id=migmag_eval_probe target_id=system.site"
