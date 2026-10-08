#!/usr/bin/env bash
# Execution RESET: create/replace a view vrs_task2 whose default display already has the Views
# random seed sort but configured to reshuffle HOURLY (reset_seed_int=3600), so verify FAILS
# until the agent changes the reset interval to daily (86400). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vrs_task2")) { $v->delete(); }
  View::create([
    "id" => "vrs_task2", "label" => "VRS Task 2",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "sorts" => [
            "random_seed" => [
              "id" => "random_seed", "table" => "views", "field" => "random_seed",
              "plugin_id" => "views_random_seed_random",
              "user_seed_type" => "same_per_user", "anonymous_session" => FALSE,
              "reset_seed_int" => 3600, "reset_seed_custom" => 300, "reuse_seed" => "",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vrs_task2 has Random seed sort with reset_seed_int=3600 (hourly)"
