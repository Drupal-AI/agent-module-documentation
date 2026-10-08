#!/usr/bin/env bash
# Execution RESET: (re)create view sais_dym with an EMPTY header (no spellcheck area handler),
# so verify FAILS until the agent adds search_api_spellcheck_did_you_mean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("sais_dym")) { $v->delete(); }
  View::create([
    "id" => "sais_dym", "label" => "SAIS DidYouMean Exec",
    "base_table" => "node_field_data", "base_field" => "nid",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["header" => []],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view sais_dym present with empty header (no spellcheck handler)"
