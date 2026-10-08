#!/usr/bin/env bash
# Introspection SETUP: create the view 'vfs_known' with a views_filters_summary area configured
# with known, distinctive option values so an inspecting agent can read them back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vfs_known")) { $v->delete(); }
  View::create([
    "id" => "vfs_known", "label" => "VFS Known", "base_table" => "node_field_data",
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
              "filters_summary_prefix"=>"VFS Known Prefix 7Q",
              "filters_summary_separator"=>" / ",
              "show_reset_link"=>TRUE,"filters_reset_link_title"=>"Reset",
              "filters_result_label"=>["singular"=>"vfsthing","plural"=>"vfsthings"],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vfs_known with prefix='VFS Known Prefix 7Q', plural label 'vfsthings'"
