#!/usr/bin/env bash
# Introspection SETUP: create a view vrs_user whose default display uses the Views random seed
# sort configured with user_seed_type=diff_per_user (a different random order per user), so an
# agent can read back the per-user behaviour. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vrs_user")) { $v->delete(); }
  View::create([
    "id" => "vrs_user", "label" => "VRS User",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "sorts" => [
            "random_seed" => [
              "id" => "random_seed", "table" => "views", "field" => "random_seed",
              "plugin_id" => "views_random_seed_random",
              "user_seed_type" => "diff_per_user", "anonymous_session" => TRUE,
              "reset_seed_int" => 3600, "reset_seed_custom" => 300, "reuse_seed" => "",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vrs_user has Random seed sort with user_seed_type=diff_per_user"
