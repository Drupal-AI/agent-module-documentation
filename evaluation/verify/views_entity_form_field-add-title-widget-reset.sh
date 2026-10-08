#!/usr/bin/env bash
# Execution RESET: (re)create the view veff_task as a plain node table with NO
# views_entity_form_field column, so verify FAILS until the agent adds one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("veff_task")) { $v->delete(); }
  View::create([
    "id" => "veff_task",
    "label" => "VEFF Task",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VEFF Task",
          "style" => ["type" => "table"],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "mini", "options" => ["items_per_page" => 10]],
          "fields" => [
            "nid" => ["id" => "nid", "table" => "node_field_data", "field" => "nid",
              "entity_type" => "node", "entity_field" => "nid", "plugin_id" => "field"],
          ],
        ],
      ],
      "page_1" => [
        "id" => "page_1", "display_plugin" => "page", "display_title" => "Page", "position" => 1,
        "display_options" => ["path" => "veff-task"],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
echo "reset: view veff_task has no entity_form_field column"
