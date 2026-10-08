#!/usr/bin/env bash
# Execution RESET: create/overwrite view "acbb_tray" whose Add Content by Bundle footer link
# targets node/article as a NORMAL page link (target=""). Verify FAILS until the agent
# switches it to open in an off-canvas tray (target="tray"). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("acbb_tray")) { $v->delete(); }
  View::create([
    "id" => "acbb_tray", "label" => "ACBB Tray", "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default",
      "position" => 0,
      "display_options" => ["footer" => ["add_content_by_bundle" => [
        "id" => "add_content_by_bundle", "table" => "views", "field" => "add_content_by_bundle",
        "plugin_id" => "add_content_by_bundle", "relationship" => "none", "group_type" => "group",
        "type" => "node", "bundle" => "article", "label" => "Add article",
        "class" => "button", "target" => "", "empty" => TRUE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view acbb_tray footer link target='' (normal page link)"
