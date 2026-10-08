#!/usr/bin/env bash
# Introspection SETUP: create a namespaced view sais_known with the
# search_api_spellcheck_did_you_mean area handler in its HEADER (count=7,
# hide_on_result=FALSE, collate=TRUE), so an inspecting agent can read back which
# spellcheck handler/options are configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sais_known")) { $v->delete(); }
  View::create([
    "id" => "sais_known", "label" => "SAIS Known",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["header" => ["search_api_spellcheck_did_you_mean" => [
        "id" => "search_api_spellcheck_did_you_mean", "table" => "views",
        "field" => "search_api_spellcheck_did_you_mean",
        "plugin_id" => "search_api_spellcheck_did_you_mean",
        "search_api_spellcheck_count" => 7,
        "search_api_spellcheck_hide_on_result" => FALSE,
        "search_api_spellcheck_collate" => TRUE,
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view sais_known header has search_api_spellcheck_did_you_mean (count=7)"
