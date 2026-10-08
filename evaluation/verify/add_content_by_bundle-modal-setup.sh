#!/usr/bin/env bash
# Introspection SETUP: create a view "acbb_modal_known" whose Add Content by Bundle footer
# link opens the add form in a MODAL dialog of width 850px. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("acbb_modal_known")) { $v->delete(); }
  View::create([
    "id" => "acbb_modal_known", "label" => "ACBB Modal Known", "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default",
      "position" => 0,
      "display_options" => ["footer" => ["add_content_by_bundle" => [
        "id" => "add_content_by_bundle", "table" => "views", "field" => "add_content_by_bundle",
        "plugin_id" => "add_content_by_bundle", "relationship" => "none", "group_type" => "group",
        "type" => "node", "bundle" => "page", "label" => "Add Page (modal)",
        "class" => "button", "target" => "modal", "width" => 850, "empty" => TRUE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view acbb_modal_known footer link target=modal width=850"
