#!/usr/bin/env bash
# Introspection SETUP: create a view vsmf_known (base node_field_data) whose default display has a
# Simple Math Field with a known formula. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsmf_known")) { $v->delete(); }
  View::create([
    "id" => "vsmf_known", "label" => "VSMF Known", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["fields" => [
        "field_views_simple_math_field" => [
          "id" => "field_views_simple_math_field", "table" => "views_simple_math_field",
          "field" => "field_views_simple_math_field", "plugin_id" => "field_views_simple_math_field",
          "fieldset_one" => ["data_field" => ["nid" => "nid", "vid" => "vid"], "formula" => "(@nid + @vid) / 2"],
          "mute_logs" => 0,
        ],
      ]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vsmf_known Simple Math Field formula = (@nid + @vid) / 2"
