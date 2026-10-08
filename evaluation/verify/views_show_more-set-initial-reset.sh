#!/usr/bin/env bash
# Execution RESET: create a view 'vsm_eval_initial' with the show_more pager but initial=0, so
# verify FAILS until the agent sets the first-page count to 10. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsm_eval_initial")) { $v->delete(); }
  View::create([
    "id" => "vsm_eval_initial", "label" => "VSM Eval Initial", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "default", "options" => []],
        "row" => ["type" => "fields", "options" => []],
        "pager" => ["type" => "show_more", "options" => ["items_per_page" => 6, "offset" => 0, "id" => 0, "initial" => 0, "show_more_text" => "Show more", "result_display_method" => "append"]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vsm_eval_initial show_more pager initial=0"
