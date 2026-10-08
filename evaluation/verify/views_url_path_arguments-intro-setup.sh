#!/usr/bin/env bash
# Introspection SETUP (views_url_path_arguments): create view vupa_intro_view whose
# Content: ID contextual filter uses the views_url_path argument-default plugin with a
# static segment prefix "reports". An inspecting agent reads back the plugin id / segment.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vupa_intro_view")) { $v->delete(); }
  View::create([
    "id" => "vupa_intro_view", "label" => "VUPA Intro View", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["arguments" => ["nid" => [
        "id" => "nid", "table" => "node_field_data", "field" => "nid", "plugin_id" => "node_nid",
        "default_action" => "default", "default_argument_type" => "views_url_path",
        "default_argument_options" => ["segments" => "reports", "provide_static_segments" => TRUE],
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: vupa_intro_view arg nid default_argument_type=views_url_path segments=reports"
