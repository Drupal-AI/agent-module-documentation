#!/usr/bin/env bash
# Introspection SETUP: create a view 'vsm_eval_text' whose Show more pager has a distinctive button
# label, so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vsm_eval_text")) { $v->delete(); }
  View::create([
    "id" => "vsm_eval_text", "label" => "VSM Eval Text", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "style" => ["type" => "default", "options" => []],
        "row" => ["type" => "fields", "options" => []],
        "pager" => ["type" => "show_more", "options" => ["items_per_page" => 6, "offset" => 0, "id" => 0, "initial" => 0, "show_more_text" => "Load more articles", "result_display_method" => "append"]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vsm_eval_text show_more_text='Load more articles'"
