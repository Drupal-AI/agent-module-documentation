#!/usr/bin/env bash
# Introspection SETUP: create a view jav_known whose default display has the jsonapi_views
# extender DISABLED (enabled=false = NOT exposed), so an agent can inspect and report it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("jav_known")) { $v->delete(); }
  View::create([
    "id" => "jav_known", "label" => "JAV Known", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["display_extenders" => ["jsonapi_views" => ["enabled" => FALSE]]],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view jav_known default display jsonapi_views.enabled=false (not exposed)"
