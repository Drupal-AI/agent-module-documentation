#!/usr/bin/env bash
# Execution RESET: create a view 'vsm_eval_task' whose default display uses the core 'full' pager
# — NOT show_more — so verify FAILS until the agent switches the pager. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsm_eval_task")) { $v->delete(); }
  View::create([
    "id" => "vsm_eval_task", "label" => "VSM Eval Task", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "default", "options" => []],
        "row" => ["type" => "fields", "options" => []],
        "pager" => ["type" => "full", "options" => ["items_per_page" => 10]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vsm_eval_task pager=full"
