#!/usr/bin/env bash
# Introspection SETUP: create a view (vccs_known) that already contains the
# views_cm_current_state "Current state" field, so an inspecting agent can read back which
# view uses the current_state_views_field handler. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vccs_known")) {
    View::create([
      "id" => "vccs_known", "label" => "VCCS known editorial view",
      "base_table" => "node_field_data",
      "display" => [
        "default" => [
          "id" => "default", "display_title" => "Default", "display_plugin" => "default", "position" => 0,
          "display_options" => [
            "fields" => [
              "current_state_views_field" => [
                "id" => "current_state_views_field", "table" => "views",
                "field" => "current_state_views_field", "plugin_id" => "current_state_views_field",
                "relationship" => "none", "label" => "Current state",
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vccs_known created with current_state_views_field"
