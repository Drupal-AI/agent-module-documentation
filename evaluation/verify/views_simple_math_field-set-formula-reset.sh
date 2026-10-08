#!/usr/bin/env bash
# Execution RESET: create a view vsmf_calc that already has a Simple Math Field but with an EMPTY
# formula, so verify FAILS until the agent sets the required formula. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsmf_calc")) { $v->delete(); }
  View::create([
    "id" => "vsmf_calc", "label" => "VSMF Calc", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["fields" => [
        "field_views_simple_math_field" => [
          "id" => "field_views_simple_math_field", "table" => "views_simple_math_field",
          "field" => "field_views_simple_math_field", "plugin_id" => "field_views_simple_math_field",
          "fieldset_one" => ["data_field" => ["nid" => "nid"], "formula" => ""],
          "mute_logs" => 0,
        ],
      ]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vsmf_calc Simple Math Field formula is empty"
