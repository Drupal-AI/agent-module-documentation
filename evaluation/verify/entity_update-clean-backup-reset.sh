#!/usr/bin/env bash
# Execution RESET: seed three rows into the module's entity_update backup table so the table is
# NOT empty; verify FAILS until the agent empties it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->truncate("entity_update")->execute();
  foreach ([7001, 7002, 7003] as $id) {
    $db->insert("entity_update")->fields([
      "entity_type" => "eu_stale",
      "entity_id" => (string) $id,
      "entity_class" => "Drupal\\\\node\\\\Entity\\\\Node",
      "status" => 0,
      "data" => serialize(["nid" => $id]),
    ])->execute();
  }
' >/dev/null 2>&1
echo "reset: entity_update backup table seeded with 3 stale rows"
