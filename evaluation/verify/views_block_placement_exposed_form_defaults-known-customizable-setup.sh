#!/usr/bin/env bash
# Introspection SETUP: create View vbpefd_view (block display) and mark the exposed 'type' filter
# customizable (customizable_exposed_filters). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbpefd_view")) { $v->delete(); }
  View::create(["id" => "vbpefd_view", "label" => "VBPEFD View", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0, "display_options" => [
        "filters" => [
          "title" => ["id" => "title", "table" => "node_field_data", "field" => "title", "entity_type" => "node", "entity_field" => "title", "plugin_id" => "string", "operator" => "contains", "exposed" => TRUE, "expose" => ["identifier" => "title", "label" => "Title"]],
          "type" => ["id" => "type", "table" => "node_field_data", "field" => "type", "entity_type" => "node", "entity_field" => "type", "plugin_id" => "bundle", "exposed" => TRUE, "expose" => ["identifier" => "type", "label" => "Type"]],
        ],
      ]],
      "block_1" => ["display_plugin" => "block", "id" => "block_1", "display_title" => "Block", "position" => 1, "display_options" => ["customizable_exposed_filters" => ["type" => "type"]]],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: views.view.vbpefd_view block_1 customizable_exposed_filters={type:type}"
