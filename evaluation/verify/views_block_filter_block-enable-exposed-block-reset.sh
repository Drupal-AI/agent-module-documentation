#!/usr/bin/env bash
# Execution RESET: (re)create the view vbfb_task with a block display block_1 that has an
# exposed Title filter but "Exposed form in block" OFF (exposed_block: false), so verify FAILS
# until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbfb_task")) { $v->delete(); }
  View::create([
    "id" => "vbfb_task",
    "label" => "VBFB Task",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VBFB Task",
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
        "display_options" => ["exposed_block" => FALSE],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vbfb_task block_1 has exposed_block: false"
