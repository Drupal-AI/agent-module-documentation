#!/usr/bin/env bash
# Introspection SETUP (view_custom_table): create a real table vct_known and register it in the
# view_custom_table.tables config with a distinctive description, so an inspecting agent can read
# it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::database()->schema();
  if (!$s->tableExists("vct_known")) {
    $s->createTable("vct_known", ["fields" => [
      "id" => ["type" => "serial", "not null" => TRUE],
      "title" => ["type" => "varchar", "length" => 255],
      "created" => ["type" => "int"],
    ], "primary key" => ["id"]]);
  }
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  $c->set("vct_known.table_name", "vct_known")
    ->set("vct_known.table_database", "default")
    ->set("vct_known.description", "VCT Known Report")
    ->set("vct_known.column_relations", serialize([]))
    ->set("vct_known.created_by", "1")
    ->save();
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: table vct_known registered (description='VCT Known Report')"
