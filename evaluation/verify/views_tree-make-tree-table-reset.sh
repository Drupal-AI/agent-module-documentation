#!/usr/bin/env bash
# Execution RESET: (re)create view "views_tree_table_task" with a core "table" style and NO
# tree configuration, so verify FAILS until the agent switches it to the Views Tree
# "tree_table" style and sets display_hierarchy_column. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_tree_table_task")) { $v->delete(); }
  View::create([
    "id" => "views_tree_table_task",
    "label" => "Views Tree Table Task",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "style" => ["type" => "table", "options" => []],
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
echo "reset: views.view.views_tree_table_task style=table (no tree config)"
