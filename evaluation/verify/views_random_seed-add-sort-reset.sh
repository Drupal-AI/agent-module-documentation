#!/usr/bin/env bash
# Execution RESET: create/replace a view vrs_task whose default display sorts by 'created' and
# has NO Views random seed sort, so verify FAILS until the agent adds the Random seed sort.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vrs_task")) { $v->delete(); }
  View::create([
    "id" => "vrs_task", "label" => "VRS Task",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => [
          "sorts" => [
            "created" => [
              "id" => "created", "table" => "node_field_data", "field" => "created",
              "plugin_id" => "date", "order" => "DESC",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vrs_task present sorting by created (no random seed sort)"
