#!/usr/bin/env bash
# Execution RESET: (re)create view sais_sug with an EMPTY footer (no spellcheck area handler),
# so verify FAILS until the agent adds search_api_spellcheck_suggestions. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sais_sug")) { $v->delete(); }
  View::create([
    "id" => "sais_sug", "label" => "SAIS Suggestions Exec",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["footer" => []],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sais_sug present with empty footer (no spellcheck handler)"
