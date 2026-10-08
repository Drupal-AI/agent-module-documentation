#!/usr/bin/env bash
# Introspection SETUP: create a view "views_tree_table_intro" whose default display uses the
# Views Tree "tree_table" style with a known display_hierarchy_column, so an inspecting agent can
# read the hierarchy column back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_tree_table_intro")) { $v->delete(); }
  View::create([
    "id" => "views_tree_table_intro",
    "label" => "Views Tree Table Intro",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "style" => [
            "type" => "tree_table",
            "options" => [
              "main_field" => "nid",
              "parent_field" => "field_parent_target_id",
              "display_hierarchy_column" => "title",
            ],
          ],
          "fields" => [
            "nid" => ["id"=>"nid","table"=>"node_field_data","field"=>"nid","plugin_id"=>"field"],
            "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field"],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.views_tree_table_intro style=tree_table display_hierarchy_column=title"
