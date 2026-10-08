#!/usr/bin/env bash
# Introspection SETUP: views_parity_row_demo with cadence frequency=4 (alt view_mode full). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_parity_row_demo")) { $v->delete(); }
  View::create([
    "id" => "views_parity_row_demo", "label" => "Views Parity Row demo",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "row" => [
            "type" => "views_parity_row_entity:node",
            "options" => [
              "view_mode" => "teaser",
              "views_parity_row_enable" => true,
              "views_parity_row" => ["frequency" => "4", "start" => "0", "end" => "0", "view_mode" => "full"],
              "views_parity_row_per_row_enable" => false,
              "views_parity_row_per_row" => [],
            ],
          ],
          "pager" => ["type" => "none"],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "ok: views_parity_row_demo written"
