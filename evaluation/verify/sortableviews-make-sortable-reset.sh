#!/usr/bin/env bash
# Execution RESET: create/replace View 'sortableviews_task' with a NON-sortable default style
# (core 'default' unformatted list, no weight_field), so verify FAILS until the agent switches
# it to a sortable style with a weight_field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (View::load("sortableviews_task")) { View::load("sortableviews_task")->delete(); }
  View::create([
    "id" => "sortableviews_task", "label" => "Sortableviews Task",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "style" => ["type" => "default", "options" => []],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "none"],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sortableviews_task uses core default style (not sortable)"
