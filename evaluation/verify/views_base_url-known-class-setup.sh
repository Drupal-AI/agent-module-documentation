#!/usr/bin/env bash
# Introspection SETUP: create a view "views_base_url_style" whose Global: Base url field is a
# link with a distinctive CSS class, so an inspecting agent can read the link_class back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_base_url_style")) { $v->delete(); }
  View::create([
    "id" => "views_base_url_style",
    "label" => "Views Base URL Style",
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
              "show_link" => TRUE,
              "show_link_options" => [
                "link_path" => "",
                "link_class" => "vbu-highlight",
              ],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.views_base_url_style base_url field link_class=vbu-highlight"
