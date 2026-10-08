#!/usr/bin/env bash
# Introspection SETUP: create a view 'vrd_intro' that uses the views_remote_data query plugin and
# a Property field with a known property_path, so the agent can inspect it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  \Drupal::configFactory()->getEditable("views.view.vrd_intro")->delete();
  View::create([
    "id" => "vrd_intro", "label" => "VRD Intro", "base_table" => "vrd_remote_source",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => [
        "query" => ["type" => "views_remote_data_query", "options" => []],
        "fields" => ["property" => [
          "id" => "property", "table" => "vrd_remote_source", "field" => "property",
          "plugin_id" => "views_remote_data_property", "property_path" => "card.title",
        ]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view vrd_intro (query views_remote_data_query, property_path card.title)"
