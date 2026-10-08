#!/usr/bin/env bash
# Execution RESET: create view vex_summary with an empty footer (no extra_result area), so verify
# FAILS until the agent adds the views_extras 'extra_result' area handler. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($e = View::load("vex_summary")) { $e->delete(); }
  View::create([
    "id" => "vex_summary", "label" => "VEX Summary", "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["footer" => []],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vex_summary has empty footer (no extra_result)"
