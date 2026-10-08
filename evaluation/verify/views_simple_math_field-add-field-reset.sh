#!/usr/bin/env bash
# Execution RESET: create a view vsmf_task (base node_field_data) WITHOUT any Simple Math Field, so
# verify FAILS until the agent adds one. Idempotent (recreates the view). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsmf_task")) { $v->delete(); }
  View::create([
    "id" => "vsmf_task", "label" => "VSMF Task", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["fields" => [
        "title" => ["id" => "title", "table" => "node_field_data", "field" => "title", "plugin_id" => "field"],
      ]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vsmf_task has no Simple Math Field"
