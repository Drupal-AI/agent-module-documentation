#!/usr/bin/env bash
# Introspection SETUP: create a view 'sv_eval_list' using Semantic Views Style with the list
# wrapper element set to an ordered list (ol), so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sv_eval_list")) { $v->delete(); }
  View::create([
    "id" => "sv_eval_list", "label" => "SV Eval List", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "pager" => ["type" => "full", "options" => ["items_per_page" => 10]],
        "style" => ["type" => "semanticviews_style", "options" => ["group" => ["element_type" => "h3", "attributes" => "class|title"], "list" => ["element_type" => "ol", "attributes" => ""], "row" => ["element_type" => "li", "attributes" => "class|", "first_class" => "first", "last_class" => "last", "last_every_nth" => "0", "striping_classes" => "odd even"]]],
        "row" => ["type" => "fields", "options" => []],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sv_eval_list list element_type=ol"
