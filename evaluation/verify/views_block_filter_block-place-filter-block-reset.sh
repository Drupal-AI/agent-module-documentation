#!/usr/bin/env bash
# Execution RESET: (re)create the view vbfb_place with block display block_1 whose
# "Exposed form in block" is already ON, and make sure NO block placement for the derived
# plugin views_exposed_filter_block:vbfb_place-block_1 exists, so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vbfb_place")) { $v->delete(); }
  View::create([
    "id" => "vbfb_place",
    "label" => "VBFB Place",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "title" => "VBFB Place",
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
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "views_exposed_filter_block:vbfb_place-block_1") { $b->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vbfb_place block_1 exposed_block=true, no exposed-filter block placed"
