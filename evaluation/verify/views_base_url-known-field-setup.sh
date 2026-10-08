#!/usr/bin/env bash
# Introspection SETUP: create a view "views_base_url_intro" with the Global: Base url (base_url)
# field configured as a link with a known link_path, so an inspecting agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_base_url_intro")) { $v->delete(); }
  View::create([
    "id" => "views_base_url_intro",
    "label" => "Views Base URL Intro",
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
                "link_path" => "node/1",
                "link_text" => "View on site",
                "link_target" => "_blank",
              ],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.views_base_url_intro base_url field show_link=true link_path=node/1"
