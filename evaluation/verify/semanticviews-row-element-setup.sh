#!/usr/bin/env bash
# Introspection SETUP: create a view 'sv_eval_style' whose default display uses the Semantic Views
# Style with a distinctive row wrapper element (article), so an agent can read it back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sv_eval_style")) { $v->delete(); }
  View::create([
    "id" => "sv_eval_style", "label" => "SV Eval Style", "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => ["display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "pager" => ["type" => "full", "options" => ["items_per_page" => 10]],
        "style" => ["type" => "semanticviews_style", "options" => ["group" => ["element_type" => "h3", "attributes" => "class|title"], "list" => ["element_type" => "", "attributes" => ""], "row" => ["element_type" => "article", "attributes" => "class|", "first_class" => "first", "last_class" => "last", "last_every_nth" => "0", "striping_classes" => "odd even"]]],
        "row" => ["type" => "fields", "options" => []],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sv_eval_style style=semanticviews_style row element_type=article"
