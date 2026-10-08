#!/usr/bin/env bash
# Execution RESET: ensure a View vtl_hard_view exists with a default display that has title +
# created fields but uses the plain 'default' style (NOT timelinejs), so verify FAILS until the
# agent switches the style to timelinejs and maps the Start date. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vtl_hard_view")) {
    View::create([
      "id" => "vtl_hard_view",
      "label" => "VTL Hard View",
      "base_table" => "node_field_data",
      "base_field" => "nid",
      "display" => [
        "default" => [
          "display_plugin" => "default",
          "id" => "default",
          "display_title" => "Default",
          "position" => 0,
          "display_options" => [
            "fields" => [
              "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","entity_type"=>"node","entity_field"=>"title","plugin_id"=>"field"],
              "created" => ["id"=>"created","table"=>"node_field_data","field"=>"created","entity_type"=>"node","entity_field"=>"created","plugin_id"=>"field","type"=>"timestamp"],
            ],
            "style" => ["type" => "default"],
            "row" => ["type" => "fields"],
          ],
        ],
      ],
    ])->save();
  }
  else {
    $v = \Drupal::configFactory()->getEditable("views.view.vtl_hard_view");
    $v->set("display.default.display_options.style.type", "default");
    $v->clear("display.default.display_options.style.options");
    $v->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: View vtl_hard_view present with style=default (not timelinejs)"
