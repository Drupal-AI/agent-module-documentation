#!/usr/bin/env bash
# Introspection SETUP: create the view vbfb_two with TWO block displays sharing one exposed
# Title filter. Only block_2 has "Exposed form in block" enabled (exposed_block: true);
# block_1 has it off. The agent must work out which display it is. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbfb_two")) { $v->delete(); }
  View::create([
    "id" => "vbfb_two",
    "label" => "VBFB Two",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VBFB Two",
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
        "id" => "block_1", "display_plugin" => "block", "display_title" => "Sidebar block", "position" => 1,
        "display_options" => ["exposed_block" => FALSE],
      ],
      "block_2" => [
        "id" => "block_2", "display_plugin" => "block", "display_title" => "Footer block", "position" => 2,
        "display_options" => ["exposed_block" => TRUE],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vbfb_two - block_1 exposed_block FALSE, block_2 exposed_block TRUE"
