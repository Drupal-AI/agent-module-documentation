#!/usr/bin/env bash
# Execution RESET: (re)create View vbpefd_task with a block display (block_1) exposing title+type
# filters and NO customizable_exposed_filters, so verify FAILS until the agent marks one.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\views\Entity\View;
  if ($v = View::load("vbpefd_task")) { $v->delete(); }
  View::create(["id" => "vbpefd_task", "label" => "VBPEFD Task", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0, "display_options" => [
        "filters" => [
          "title" => ["id" => "title", "table" => "node_field_data", "field" => "title", "entity_type" => "node", "entity_field" => "title", "plugin_id" => "string", "operator" => "contains", "exposed" => TRUE, "expose" => ["identifier" => "title", "label" => "Title"]],
          "type" => ["id" => "type", "table" => "node_field_data", "field" => "type", "entity_type" => "node", "entity_field" => "type", "plugin_id" => "bundle", "exposed" => TRUE, "expose" => ["identifier" => "type", "label" => "Type"]],
        ],
      ]],
      "block_1" => ["display_plugin" => "block", "id" => "block_1", "display_title" => "Block", "position" => 1, "display_options" => []],
    ],
  ])->save();' >/dev/null 2>&1
echo "reset: vbpefd_task present, block_1 has no customizable_exposed_filters"
