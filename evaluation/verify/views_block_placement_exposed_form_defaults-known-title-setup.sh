#!/usr/bin/env bash
# Introspection SETUP: create View vbpefd_view2 (block display) with the exposed 'title' filter
# marked customizable, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbpefd_view2")) { $v->delete(); }
  View::create(["id" => "vbpefd_view2", "label" => "VBPEFD View2", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0, "display_options" => [
        "filters" => [
          "title" => ["id" => "title", "table" => "node_field_data", "field" => "title", "entity_type" => "node", "entity_field" => "title", "plugin_id" => "string", "operator" => "contains", "exposed" => TRUE, "expose" => ["identifier" => "title", "label" => "Title"]],
        ],
      ]],
      "block_1" => ["display_plugin" => "block", "id" => "block_1", "display_title" => "Block", "position" => 1, "display_options" => ["customizable_exposed_filters" => ["title" => "title"]]],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: views.view.vbpefd_view2 block_1 customizable_exposed_filters={title:title}"
