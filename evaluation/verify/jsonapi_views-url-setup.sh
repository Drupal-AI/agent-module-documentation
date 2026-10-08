#!/usr/bin/env bash
# Introspection SETUP: create a view jav_display with a page display "page_1", so an agent
# must inspect the view to build the JSON:API URL /jsonapi/views/jav_display/page_1.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("jav_display")) { $v->delete(); }
  View::create([
    "id" => "jav_display", "label" => "JAV Display", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["display_extenders" => ["jsonapi_views" => ["enabled" => TRUE]]],
      ],
      "page_1" => [
        "display_plugin" => "page", "id" => "page_1", "display_title" => "Page",
        "position" => 1,
        "display_options" => ["path" => "jav_display-listing", "display_extenders" => ["jsonapi_views" => ["enabled" => TRUE]]],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view jav_display with displays default + page_1"
