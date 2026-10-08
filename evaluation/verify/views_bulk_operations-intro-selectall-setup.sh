#!/usr/bin/env bash
# Introspection SETUP: install a KNOWN View `eval_intro_vbo` on Content (nodes) that
# carries a Views Bulk Operations field on its default display with a KNOWN set of
# enabled bulk actions (node_publish_action, node_unpublish_action) and the
# "Select all results (all pages)" checkbox forced on (show_select_all = always_show).
# An inspecting agent reads this back via drush (config get / views) to answer.
# Idempotent: deletes any prior eval_intro_vbo first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "eval_intro_vbo";
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load($id)) { $v->delete(); }
  $field = [
    "id" => "views_bulk_operations_bulk_form",
    "table" => "views",
    "field" => "views_bulk_operations_bulk_form",
    "plugin_id" => "views_bulk_operations_bulk_form",
    "label" => "Bulk operations",
    "show_select_all" => "always_show",
    "selected_actions" => [
      ["action_id" => "node_publish_action", "preconfiguration" => []],
      ["action_id" => "node_unpublish_action", "preconfiguration" => []],
    ],
  ];
  $storage->create([
    "id" => $id,
    "label" => "Eval Intro VBO",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "fields" => ["views_bulk_operations_bulk_form" => $field],
          "pager" => ["type" => "full"],
        ],
      ],
      "page_1" => [
        "display_plugin" => "page",
        "id" => "page_1",
        "display_title" => "Page",
        "position" => 1,
        "display_options" => ["path" => "eval-intro-vbo"],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view eval_intro_vbo installed (VBO field, actions=node_publish_action,node_unpublish_action, show_select_all=always_show)"
