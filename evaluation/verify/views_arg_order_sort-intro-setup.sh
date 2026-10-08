#!/usr/bin/env bash
# Introspection SETUP (views_arg_order_sort): create view vaos_intro_view with a
# "Multi-item Argument Order" sort (plugin views_arg_order_sort_default) configured with
# inherit_type off and an explicit field_type node::nid, argument_number 3. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vaos_intro_view")) { $v->delete(); }
  View::create([
    "id" => "vaos_intro_view", "label" => "VAOS Intro View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "arguments" => ["nid" => [
          "id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid",
        ]],
        "sorts" => ["views_arg_order_sort" => [
          "id" => "views_arg_order_sort", "table" => "views_arg_order_sort", "field" => "weight",
          "plugin_id" => "views_arg_order_sort_default", "order" => "ASC",
          "argument_number" => 3, "inherit_type" => FALSE, "field_type" => "node::nid", "null_below" => TRUE,
        ]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vaos_intro_view sort views_arg_order_sort_default inherit_type=false field_type=node::nid argument_number=3"
