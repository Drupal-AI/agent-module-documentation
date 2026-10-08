#!/usr/bin/env bash
# Introspection SETUP: create a view vrs_eval whose default display uses the Views random seed
# sort configured to reshuffle DAILY (reset_seed_int=86400), so an agent can read back the
# reset interval. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vrs_eval")) { $v->delete(); }
  View::create([
    "id" => "vrs_eval", "label" => "VRS Eval",
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
              "reset_seed_int" => 86400, "reset_seed_custom" => 300, "reuse_seed" => "",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vrs_eval has Random seed sort with reset_seed_int=86400 (daily)"
