#!/usr/bin/env bash
# Introspection SETUP: create a namespaced View "vmcf_test" whose default display has a
# contextual filter (argument) using the module's menu-children argument handler
# (plugin_id: menu_children, table: node, field: menu_children_filter), so an inspecting
# agent can read back which Views handler/plugin id is in use. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vmcf_test")) { $v->delete(); }
  $view = View::create([
    "id" => "vmcf_test",
    "label" => "VMCF Test",
    "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "arguments" => [
            "menu_children_filter" => [
              "id" => "menu_children_filter",
              "table" => "node",
              "field" => "menu_children_filter",
              "plugin_id" => "menu_children",
              "target_menus" => ["main" => "main"],
            ],
          ],
        ],
      ],
    ],
  ]);
  $view->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.vmcf_test has a Menu children argument (plugin_id=menu_children) on node.menu_children_filter"
