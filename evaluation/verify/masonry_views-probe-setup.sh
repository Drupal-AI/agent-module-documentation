#!/usr/bin/env bash
# Introspection SETUP: create a view that uses the Masonry style with a distinctive gutterWidth
# so an inspecting agent can read the configured value back from live config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("masonry_views_probe")) { $v->delete(); }
  View::create([
    "id" => "masonry_views_probe", "label" => "Masonry Views Probe",
    "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "row" => ["type" => "entity:node"],
        "style" => ["type" => "masonry", "options" => ["gutterWidth" => "17"]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view masonry_views_probe uses masonry style with gutterWidth=17"
