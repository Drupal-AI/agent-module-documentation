#!/usr/bin/env bash
# Introspection SETUP: put two known rows into the module's entity backup table
# (`entity_update`, created by entity_update_schema()), as `drush upe --bkpdel` would.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->delete("entity_update")->condition("entity_type", "eu_probe")->execute();
  foreach ([["eu_probe", "4242"], ["eu_probe", "4343"]] as $row) {
    $db->insert("entity_update")->fields([
      "entity_type" => $row[0],
      "entity_id" => $row[1],
      "entity_class" => "Drupal\\\\node\\\\Entity\\\\Node",
      "status" => 0,
      "data" => serialize(["nid" => $row[1]]),
    ])->execute();
  }
' >/dev/null 2>&1
echo "setup: entity_update backup table seeded with 2 rows of entity_type eu_probe (ids 4242, 4343)"
