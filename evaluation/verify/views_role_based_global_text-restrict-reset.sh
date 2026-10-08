#!/usr/bin/env bash
# HARD execution RESET: create/replace view vrbgt_task_view with a header Global: Text area that
# has NO role restriction (roles empty), so verify FAILs until the agent restricts it to the
# authenticated role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vrbgt_task_view")) { $v->delete(); }
  View::create([
    "id" => "vrbgt_task_view", "label" => "VRBGT task view", "base_table" => "node_field_data",
    "display" => ["default" => [
      "id" => "default", "display_plugin" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["header" => ["area_text" => [
        "id" => "area_text", "table" => "views", "field" => "area", "plugin_id" => "text",
        "content" => ["value" => "<p>Welcome</p>", "format" => "basic_html"],
        "roles_fieldset" => ["roles" => [], "negate" => FALSE],
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vrbgt_task_view header text area with NO role restriction"
