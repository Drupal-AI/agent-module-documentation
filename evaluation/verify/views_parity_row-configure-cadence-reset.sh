#!/usr/bin/env bash
# Execution RESET: views_parity_row_demo with a PLAIN entity:node row (no parity) so verify FAILS until the agent switches to the parity plugin. Idempotent. Exit 0.
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
            "type" => "entity:node",
            "options" => ["view_mode" => "teaser"],
          ],
          "pager" => ["type" => "none"],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "ok: views_parity_row_demo written"
