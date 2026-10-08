#!/usr/bin/env bash
# Execution RESET: (re)create view vccs_task with ONLY a title field and NO current-state field,
# so verify FAILS until the agent adds views_cm_current_state's "Current state" field. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vccs_task")) { $v->delete(); }
  View::create([
    "id" => "vccs_task", "label" => "VCCS task view",
    "base_table" => "node_field_data",
    "display" => [
      "default" => [
        "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
        "display_options" => [
          "fields" => [
            "title" => [
              "id" => "title", "table" => "node_field_data", "field" => "title",
              "entity_type" => "node", "entity_field" => "title", "plugin_id" => "field", "label" => "Title",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vccs_task present with title field only (no current-state field)"
