#!/usr/bin/env bash
# Introspection SETUP: create a view vri_known_view whose default display uses the
# row_insert style, inserting custom HTML after every 4th row. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vri_known_view")) { $v->delete(); }
  View::create([
    "id" => "vri_known_view", "label" => "VRI Known View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "row_insert", "options" => [
          "use_plugin" => TRUE, "data_mode" => "vri_text",
          "custom_row_data" => "<div class=\"promo\">VRI-PROMO-XYZ</div>", "rows_number" => 4,
        ]],
        "row" => ["type" => "fields"],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vri_known_view uses row_insert, rows_number=4, custom_row_data contains VRI-PROMO-XYZ"
