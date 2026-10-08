#!/usr/bin/env bash
# Introspection SETUP: create two migrate_plus migrations, ssi_plain (core sql map) and
# ssi_smart (smart_sql map), so the agent must inspect config to say which hides behind
# the smart_sql id map. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("migration");
  $base = ["migration_tags"=>[], "process"=>[],
    "source"=>["plugin"=>"embedded_data","data_rows"=>[],"ids"=>["id"=>["type"=>"integer"]]],
    "destination"=>["plugin"=>"null"]];
  if (!$s->load("ssi_plain")) { $s->create(["id"=>"ssi_plain","label"=>"SSI plain","idMap"=>["plugin"=>"sql"]] + $base)->save(); }
  if (!$s->load("ssi_smart")) { $s->create(["id"=>"ssi_smart","label"=>"SSI smart","idMap"=>["plugin"=>"smart_sql"]] + $base)->save(); }
' >/dev/null 2>&1
echo "setup: ssi_plain (sql) + ssi_smart (smart_sql) created"
