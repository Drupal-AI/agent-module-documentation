#!/usr/bin/env bash
# Execution RESET: (re)create vri_reconfig_view using row_insert with rows_number=2 and
# row_header=FALSE, so verify (wants rows_number=5 AND row_header=TRUE) FAILS until the
# agent reconfigures it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vri_reconfig_view")) { $v->delete(); }
  View::create([
    "id" => "vri_reconfig_view", "label" => "VRI Reconfig View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "row_insert", "options" => [
          "use_plugin" => TRUE, "data_mode" => "vri_text",
          "custom_row_data" => "<div>ad</div>", "rows_number" => 2, "row_header" => FALSE,
        ]],
        "row" => ["type" => "fields"],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vri_reconfig_view row_insert rows_number=2 row_header=FALSE"
