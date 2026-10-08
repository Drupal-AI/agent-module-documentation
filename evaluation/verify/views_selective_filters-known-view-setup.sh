#!/usr/bin/env bash
# Introspection SETUP: create a view "vsf_eval_view" whose default display has an exposed
# selective filter (plugin_id views_selective_filters_filter) on the node type field, so an
# agent can inspect the live view and identify the selective filter. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if (!$s->load("vsf_eval_view")) {
    $s->create([
      "id" => "vsf_eval_view",
      "label" => "VSF Eval View",
      "base_table" => "node_field_data",
      "base_field" => "nid",
      "display" => [
        "default" => [
          "id" => "default",
          "display_plugin" => "default",
          "display_title" => "Default",
          "position" => 0,
          "display_options" => [
            "filters" => [
              "type_selective" => [
                "id" => "type_selective",
                "table" => "node_field_data",
                "field" => "type_selective",
                "entity_type" => "node",
                "plugin_id" => "views_selective_filters_filter",
                "exposed" => TRUE,
                "expose" => ["identifier" => "type", "label" => "Type"],
                "selective_items_limit" => 100,
                "selective_display_sort" => "ASC",
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view vsf_eval_view has a views_selective_filters_filter on type_selective"
