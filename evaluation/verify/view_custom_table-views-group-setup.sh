#!/usr/bin/env bash
# Introspection SETUP (view_custom_table): create table vct_grp and register it, then rebuild Views
# data so it appears as a Views base table. The agent must inspect live Views data. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::database()->schema();
  if (!$s->tableExists("vct_grp")) {
    $s->createTable("vct_grp", ["fields" => [
      "id" => ["type" => "serial", "not null" => TRUE],
      "name" => ["type" => "varchar", "length" => 255],
    ], "primary key" => ["id"]]);
  }
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  $c->set("vct_grp.table_name", "vct_grp")
    ->set("vct_grp.table_database", "default")
    ->set("vct_grp.description", "VCT Group Demo")
    ->set("vct_grp.column_relations", serialize([]))
    ->set("vct_grp.created_by", "1")
    ->save();
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: table vct_grp registered and Views data rebuilt"
