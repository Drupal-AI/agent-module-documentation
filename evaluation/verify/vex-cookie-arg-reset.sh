#!/usr/bin/env bash
# Execution RESET: create view vex_task with a nid contextual filter whose default value is a FIXED
# value (not the views_extras cookie plugin), so verify FAILS until the agent switches it to cookie.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($e = View::load("vex_task")) { $e->delete(); }
  View::create([
    "id" => "vex_task", "label" => "VEX Task", "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "arguments" => [
            "nid" => [
              "id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid",
              "default_action" => "default", "default_argument_type" => "fixed",
              "default_argument_options" => ["argument" => "1"],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vex_task nid argument uses default_argument_type=fixed"
