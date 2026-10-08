#!/usr/bin/env bash
# Introspection SETUP: create a namespaced view sais_footer with the
# search_api_spellcheck_suggestions area handler in its FOOTER (count=5), so an agent can
# read back in which display section the spellcheck handler sits. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sais_footer")) { $v->delete(); }
  View::create([
    "id" => "sais_footer", "label" => "SAIS Footer",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["footer" => ["search_api_spellcheck_suggestions" => [
        "id" => "search_api_spellcheck_suggestions", "table" => "views",
        "field" => "search_api_spellcheck_suggestions",
        "plugin_id" => "search_api_spellcheck_suggestions",
        "search_api_spellcheck_count" => 5,
        "search_api_spellcheck_hide_on_result" => TRUE,
        "search_api_spellcheck_collate" => FALSE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sais_footer footer has search_api_spellcheck_suggestions (count=5)"
