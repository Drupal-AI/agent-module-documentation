#!/usr/bin/env bash
# Execution RESET: create/replace View 'sortableviews_ha' whose default display already uses a
# sortable style (sortable_default, weight_field=field_sv_weight) but has NEITHER the drag
# handle field NOR the save area, so verify FAILS until the agent adds both. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (View::load("sortableviews_ha")) { View::load("sortableviews_ha")->delete(); }
  View::create([
    "id" => "sortableviews_ha", "label" => "Sortableviews HA",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "sortable_default", "options" => ["weight_field" => "field_sv_weight"]],
          "row" => ["type" => "fields"], "pager" => ["type" => "none"],
          "fields" => [], "header" => [], "footer" => [],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sortableviews_ha sortable but missing drag handle + save area"
