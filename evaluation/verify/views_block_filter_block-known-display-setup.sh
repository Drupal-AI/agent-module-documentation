#!/usr/bin/env bash
# Introspection SETUP: create the view vbfb_demo with a block display (block_1) that has an
# exposed Title filter and "Exposed form in block" turned ON (exposed_block: true), so the
# derived block plugin views_exposed_filter_block:vbfb_demo-block_1 exists on the live site.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbfb_demo")) { $v->delete(); }
  View::create([
    "id" => "vbfb_demo",
    "label" => "VBFB Demo",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VBFB Demo",
          "style" => ["type" => "default"],
          "row" => ["type" => "fields"],
          "pager" => ["type" => "mini", "options" => ["items_per_page" => 10]],
          "fields" => [
            "title" => ["id" => "title", "table" => "node_field_data", "field" => "title",
              "entity_type" => "node", "entity_field" => "title", "plugin_id" => "field"],
          ],
          "filters" => [
            "title" => ["id" => "title", "table" => "node_field_data", "field" => "title",
              "entity_type" => "node", "entity_field" => "title", "plugin_id" => "string",
              "operator" => "contains", "exposed" => TRUE,
              "expose" => ["operator_id" => "title_op", "label" => "Title", "identifier" => "title", "operator" => "title_op"]],
          ],
        ],
      ],
      "block_1" => [
        "id" => "block_1", "display_plugin" => "block", "display_title" => "Block", "position" => 1,
        "display_options" => ["exposed_block" => TRUE],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vbfb_demo block_1 has exposed_block: true"
