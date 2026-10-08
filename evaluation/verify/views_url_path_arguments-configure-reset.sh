#!/usr/bin/env bash
# Execution RESET (views_url_path_arguments): (re)create vupa_task_view with a Content: ID
# contextual filter that does NOT use views_url_path (default_argument_type=fixed, validate
# type=none), so both verify scripts FAIL until the agent configures the plugin. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vupa_task_view")) { $v->delete(); }
  View::create([
    "id" => "vupa_task_view", "label" => "VUPA Task View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["arguments" => ["nid" => [
        "id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid",
        "default_action" => "default", "default_argument_type" => "fixed",
        "default_argument_options" => ["argument" => ""],
        "validate" => ["type" => "none", "fail" => "not found"],
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vupa_task_view arg nid uses default_argument_type=fixed, validate=none"
