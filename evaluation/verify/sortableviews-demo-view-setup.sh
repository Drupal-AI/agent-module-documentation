#!/usr/bin/env bash
# Introspection SETUP: create a View 'sortableviews_demo' whose default display uses the
# sortable_table style with weight_field = field_sv_weight, so an agent can read the sortable
# style and weight field from the view config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (View::load("sortableviews_demo")) { View::load("sortableviews_demo")->delete(); }
  View::create([
    "id" => "sortableviews_demo", "label" => "Sortableviews Demo",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "sortable_table", "options" => ["weight_field" => "field_sv_weight"]],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "none"],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sortableviews_demo uses sortable_table, weight_field=field_sv_weight"
