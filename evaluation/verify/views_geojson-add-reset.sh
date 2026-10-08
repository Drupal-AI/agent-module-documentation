#!/usr/bin/env bash
# HARD execution RESET: create/replace view vgj_task_view with ONLY a default display (no GeoJSON
# output), so verify FAILs until the agent adds a GeoJSON display/style. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vgj_task_view")) { $v->delete(); }
  View::create([
    "id" => "vgj_task_view", "label" => "VGJ task view", "base_table" => "node_field_data",
    "display" => ["default" => ["id" => "default", "display_plugin" => "default", "display_title" => "Default", "position" => 0, "display_options" => []]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vgj_task_view has only a default display"
