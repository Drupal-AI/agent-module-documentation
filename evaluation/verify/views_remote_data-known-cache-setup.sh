#!/usr/bin/env bash
# Introspection SETUP: create a view 'vrd_cacheview' on the remote query using the time-based
# remote-data cache plugin so the agent can read which cache plugin is configured. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  \Drupal::configFactory()->getEditable("views.view.vrd_cacheview")->delete();
  View::create([
    "id" => "vrd_cacheview", "label" => "VRD Cacheview", "base_table" => "vrd_remote_source",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => [
        "query" => ["type" => "views_remote_data_query", "options" => []],
        "cache" => ["type" => "views_remote_data_time", "options" => [
          "results_lifespan" => 3600, "results_lifespan_custom" => 0,
          "output_lifespan" => 3600, "output_lifespan_custom" => 0,
        ]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view vrd_cacheview (cache views_remote_data_time, 3600s)"
