#!/usr/bin/env bash
# Execution RESET: (re)create the view 'vfs_task' with an exposed Title filter but NO
# views_filters_summary area, so verify FAILS until the agent adds the summary area. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vfs_task")) { $v->delete(); }
  View::create([
    "id" => "vfs_task", "label" => "VFS Task", "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "filters" => [
            "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"string","exposed"=>TRUE,"expose"=>["identifier"=>"title","label"=>"Title"]],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vfs_task created without a views_filters_summary area"
