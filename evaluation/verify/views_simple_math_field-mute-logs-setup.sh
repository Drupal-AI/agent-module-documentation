#!/usr/bin/env bash
# Introspection SETUP: create a view vsmf_mute whose Simple Math Field has database logging of
# division-by-zero muted (mute_logs = 1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsmf_mute")) { $v->delete(); }
  View::create([
    "id" => "vsmf_mute", "label" => "VSMF Mute", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["fields" => [
        "field_views_simple_math_field" => [
          "id" => "field_views_simple_math_field", "table" => "views_simple_math_field",
          "field" => "field_views_simple_math_field", "plugin_id" => "field_views_simple_math_field",
          "fieldset_one" => ["data_field" => ["nid" => "nid"], "formula" => "@nid / 0"],
          "mute_logs" => 1,
        ],
      ]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vsmf_mute Simple Math Field mute_logs = 1"
