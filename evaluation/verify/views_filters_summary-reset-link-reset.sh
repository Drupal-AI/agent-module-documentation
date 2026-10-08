#!/usr/bin/env bash
# Execution RESET: (re)create the view 'vfs_reset' that already has a views_filters_summary area,
# but with show_reset_link=FALSE, so verify FAILS until the agent enables the reset link. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vfs_reset")) { $v->delete(); }
  View::create([
    "id" => "vfs_reset", "label" => "VFS Reset", "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "filters" => [
            "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"string","exposed"=>TRUE,"expose"=>["identifier"=>"title","label"=>"Title"]],
          ],
          "footer" => [
            "views_filters_summary" => [
              "id"=>"views_filters_summary","table"=>"views","field"=>"views_filters_summary","plugin_id"=>"views_filters_summary",
              "filters_summary_prefix"=>"for ","show_reset_link"=>FALSE,"filters_reset_link_title"=>"Reset",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vfs_reset created with summary area, show_reset_link=FALSE"
