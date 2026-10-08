#!/usr/bin/env bash
# Execution RESET: (re)create the view veff_publish as a plain node table with NO
# views_entity_form_field column, so verify FAILS until the agent adds an editable Published
# column with a fallback view mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("veff_publish")) { $v->delete(); }
  View::create([
    "id" => "veff_publish",
    "label" => "VEFF Publish",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VEFF Publish",
          "style" => ["type" => "table"],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "mini", "options" => ["items_per_page" => 10]],
          "fields" => [
            "title" => ["id" => "title", "table" => "node_field_data", "field" => "title",
              "entity_type" => "node", "entity_field" => "title", "plugin_id" => "field"],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
echo "reset: view veff_publish has no entity_form_field column"
