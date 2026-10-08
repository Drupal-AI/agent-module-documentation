#!/usr/bin/env bash
# Introspection SETUP: create the view veff_fallback whose views_entity_form_field column
# (form_field_body) is configured with a read-only fallback view mode and a VISIBLE widget
# title, so the agent has to read the real plugin options back off the live view.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("veff_fallback")) { $v->delete(); }
  View::create([
    "id" => "veff_fallback",
    "label" => "VEFF Fallback",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VEFF Fallback",
          "style" => ["type" => "table"],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "mini", "options" => ["items_per_page" => 10]],
          "fields" => [
            "form_field_body" => [
              "id" => "form_field_body", "table" => "node_field_data", "field" => "form_field_body",
              "plugin_id" => "entity_form_field", "entity_type" => "node", "label" => "Body",
              "plugin" => [
                "type" => "text_textarea",
                "settings" => ["rows" => 3, "placeholder" => ""],
                "third_party_settings" => [],
                "hide_title" => FALSE,
                "hide_description" => TRUE,
                "fallback_view_mode" => "teaser",
              ],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: view veff_fallback form_field_body fallback_view_mode=teaser hide_title=FALSE"
