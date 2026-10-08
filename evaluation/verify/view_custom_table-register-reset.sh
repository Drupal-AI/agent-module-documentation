#!/usr/bin/env bash
# Execution RESET (view_custom_table): ensure the real table vct_task EXISTS but is NOT registered
# in view_custom_table.tables (so it is not a Views base table and verify FAILS on empty state).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::database()->schema();
  if (!$s->tableExists("vct_task")) {
    $s->createTable("vct_task", ["fields" => [
      "id" => ["type" => "serial", "not null" => TRUE],
      "title" => ["type" => "varchar", "length" => 255],
      "created" => ["type" => "int"],
    ], "primary key" => ["id"]]);
  }
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  if ($c->get("vct_task") !== NULL) { $c->clear("vct_task")->save(); }
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: table vct_task exists, NOT registered"
