#!/usr/bin/env bash
# MEDIUM introspection SETUP: create a View (vrbgt_role_view) whose header Global: Text area is
# restricted with views_role_based_global_text to hide it FROM the anonymous role (negate=TRUE),
# so an agent can read the role config back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vrbgt_role_view")) {
    View::create([
      "id" => "vrbgt_role_view", "label" => "VRBGT role view", "base_table" => "node_field_data",
      "display" => ["default" => [
        "id" => "default", "display_plugin" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["header" => ["area_text" => [
          "id" => "area_text", "table" => "views", "field" => "area", "plugin_id" => "text",
          "content" => ["value" => "<p>Members only note</p>", "format" => "basic_html"],
          "roles_fieldset" => ["roles" => ["anonymous" => "anonymous"], "negate" => TRUE],
        ]]],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vrbgt_role_view header text area roles=[anonymous] negate=TRUE"
