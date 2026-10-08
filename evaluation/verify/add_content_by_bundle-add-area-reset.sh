#!/usr/bin/env bash
# Execution RESET: create/overwrite view "acbb_task" with an EMPTY footer (no Add Content by
# Bundle handler), so verify FAILS until the agent adds one targeting node/page. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("acbb_task")) { $v->delete(); }
  View::create([
    "id" => "acbb_task", "label" => "ACBB Task", "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => ["default" => [
      "id" => "default", "display_title" => "Default", "display_plugin" => "default",
      "position" => 0, "display_options" => ["footer" => []],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view acbb_task present with empty footer (no add_content_by_bundle handler)"
