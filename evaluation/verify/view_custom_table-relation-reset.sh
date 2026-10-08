#!/usr/bin/env bash
# Execution RESET (view_custom_table): ensure table vct_rel EXISTS (with a numeric uid column) but is
# NOT registered, so no Views relationship to the user entity exists yet (verify FAILS on empty).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::database()->schema();
  if (!$s->tableExists("vct_rel")) {
    $s->createTable("vct_rel", ["fields" => [
      "id" => ["type" => "serial", "not null" => TRUE],
      "title" => ["type" => "varchar", "length" => 255],
      "uid" => ["type" => "int", "not null" => TRUE, "default" => 0],
    ], "primary key" => ["id"]]);
  }
  $c = \Drupal::configFactory()->getEditable("view_custom_table.tables");
  if ($c->get("vct_rel") !== NULL) { $c->clear("vct_rel")->save(); }
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: table vct_rel exists (uid column), NOT registered"
