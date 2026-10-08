#!/usr/bin/env bash
# Execution RESET: create a view 'sv_eval_task' whose default display uses the core 'default'
# (Unformatted list) style — NOT semanticviews — so verify FAILS until the agent switches it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sv_eval_task")) { $v->delete(); }
  View::create([
    "id" => "sv_eval_task", "label" => "SV Eval Task", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "pager" => ["type" => "full", "options" => ["items_per_page" => 10]],
        "style" => ["type" => "default", "options" => []],
        "row" => ["type" => "fields", "options" => []],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sv_eval_task style=default (unformatted)"
