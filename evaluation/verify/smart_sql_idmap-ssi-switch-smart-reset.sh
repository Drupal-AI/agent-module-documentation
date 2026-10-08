#!/usr/bin/env bash
# Execution RESET: (re)create ssi_switch with the CORE sql id map (idMap.plugin=sql) so
# verify FAILS until the agent switches it to smart_sql. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  if ($e = $s->load("ssi_switch")) { $e->delete(); }
  $s->create([
    "id"=>"ssi_switch","label"=>"SSI switch","migration_tags"=>[],
    "idMap"=>["plugin"=>"sql"], "process"=>[],
    "source"=>["plugin"=>"embedded_data","data_rows"=>[],"ids"=>["id"=>["type"=>"integer"]]],
    "destination"=>["plugin"=>"null"],
  ])->save();
' >/dev/null 2>&1
echo "reset: ssi_switch present with idMap.plugin=sql"
