#!/usr/bin/env bash
# Introspection SETUP: create the view veff_demo (table of nodes) with one editable column
# added by views_entity_form_field: a "Form field: Title" column (form_field_title /
# plugin_id entity_form_field) using the string_textfield widget with size 25.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("veff_demo")) { $v->delete(); }
  View::create([
    "id" => "veff_demo",
    "label" => "VEFF Demo",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VEFF Demo",
          "style" => ["type" => "table"],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "mini", "options" => ["items_per_page" => 10]],
          "fields" => [
            "form_field_title" => [
              "id" => "form_field_title", "table" => "node_field_data", "field" => "form_field_title",
              "plugin_id" => "entity_form_field", "entity_type" => "node", "label" => "Title",
              "plugin" => [
                "type" => "string_textfield",
                "settings" => ["size" => 25, "placeholder" => ""],
                "third_party_settings" => [],
                "hide_title" => TRUE,
                "hide_description" => TRUE,
                "fallback_view_mode" => "0",
              ],
            ],
          ],
        ],
      ],
      "page_1" => [
        "id" => "page_1", "display_plugin" => "page", "display_title" => "Page", "position" => 1,
        "display_options" => ["path" => "veff-demo"],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: view veff_demo has form_field_title (entity_form_field) with widget string_textfield"
