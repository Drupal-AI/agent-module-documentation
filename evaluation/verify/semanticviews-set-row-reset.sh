#!/usr/bin/env bash
# Execution RESET: create a view 'sv_eval_rowtask' whose default display uses the core 'fields' row
# plugin — NOT semanticviews_row — so verify FAILS until the agent switches the row plugin. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sv_eval_rowtask")) { $v->delete(); }
  View::create([
    "id" => "sv_eval_rowtask", "label" => "SV Eval Row Task", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "pager" => ["type" => "full", "options" => ["items_per_page" => 10]],
        "style" => ["type" => "semanticviews_style", "options" => ["group" => ["element_type" => "h3", "attributes" => "class|title"], "list" => ["element_type" => "", "attributes" => ""], "row" => ["element_type" => "div", "attributes" => "class|", "first_class" => "first", "last_class" => "last", "last_every_nth" => "0", "striping_classes" => "odd even"]]],
        "row" => ["type" => "fields", "options" => []],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sv_eval_rowtask row plugin=fields"
