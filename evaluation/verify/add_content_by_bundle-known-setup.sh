#!/usr/bin/env bash
# Introspection SETUP: create a view "acbb_known" with an Add Content by Bundle link in its
# footer, configured to target the node "article" bundle, so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("acbb_known")) { $v->delete(); }
  View::create([
    "id" => "acbb_known", "label" => "ACBB Known", "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default",
      "position" => 0,
      "display_options" => ["footer" => ["add_content_by_bundle" => [
        "id" => "add_content_by_bundle", "table" => "views", "field" => "add_content_by_bundle",
        "plugin_id" => "add_content_by_bundle", "relationship" => "none", "group_type" => "group",
        "type" => "node", "bundle" => "article", "label" => "Add ACBB Known",
        "class" => "button", "target" => "", "empty" => TRUE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view acbb_known footer add_content_by_bundle -> type=node bundle=article"
