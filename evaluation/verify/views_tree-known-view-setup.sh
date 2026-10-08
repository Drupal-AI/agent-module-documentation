#!/usr/bin/env bash
# Introspection SETUP: create a view "views_tree_intro" whose default display uses the
# Views Tree "tree" (list) style with a known main_field/parent_field and collapsible_tree,
# so an inspecting agent can read the style options back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_tree_intro")) { $v->delete(); }
  View::create([
    "id" => "views_tree_intro",
    "label" => "Views Tree Intro",
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
            "type" => "tree",
            "options" => [
              "main_field" => "nid",
              "parent_field" => "field_parent_target_id",
              "collapsible_tree" => "collapsed",
            ],
          ],
          "fields" => [
            "nid" => ["id"=>"nid","table"=>"node_field_data","field"=>"nid","plugin_id"=>"field"],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.views_tree_intro style=tree main_field=nid parent_field=field_parent_target_id"
