#!/usr/bin/env bash
# Execution RESET: create/replace view vlm_task with a standard 'full' (numbered) pager so
# verify FAILS until the agent switches it to the Views Load More pager. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $s->load("vlm_task")) { $v->delete(); }
  $s->create([
    "id" => "vlm_task", "label" => "VLM Task", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["pager" => ["type" => "full", "options" => ["items_per_page" => 10]]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view vlm_task present with a 'full' pager (not load_more)"
