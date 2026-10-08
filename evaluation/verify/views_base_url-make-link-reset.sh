#!/usr/bin/env bash
# Execution RESET: (re)create view "views_base_url_link_task" that already has the base_url field
# but with show_link OFF and no link_path, so verify FAILS until the agent turns it into a link
# with a link_path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_base_url_link_task")) { $v->delete(); }
  View::create([
    "id" => "views_base_url_link_task",
    "label" => "Views Base URL Link Task",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "fields" => [
            "base_url" => [
              "id" => "base_url",
              "table" => "views",
              "field" => "base_url",
              "plugin_id" => "base_url",
              "show_link" => FALSE,
              "show_link_options" => ["link_path" => ""],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.views_base_url_link_task base_url field show_link=FALSE"
