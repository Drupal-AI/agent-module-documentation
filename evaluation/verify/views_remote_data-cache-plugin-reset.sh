#!/usr/bin/env bash
# Execution RESET: (re)create the vrd_cache view on the remote query with caching set to 'none',
# so the verify (which requires the views_remote_data_time cache) FAILS until the agent switches
# it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  \Drupal::configFactory()->getEditable("views.view.vrd_cache")->delete();
  View::create([
    "id" => "vrd_cache", "label" => "VRD Cache", "base_table" => "vrd_remote_source",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
      "display_options" => [
        "query" => ["type" => "views_remote_data_query", "options" => []],
        "cache" => ["type" => "none", "options" => []],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view vrd_cache created with cache=none"
