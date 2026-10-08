#!/usr/bin/env bash
# Introspection SETUP: create a view vlm_finish using the Views Load More pager with a known
# "Finished text" (end_text). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $s->load("vlm_finish")) { $v->delete(); }
  $s->create([
    "id" => "vlm_finish", "label" => "VLM Finish", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["pager" => ["type" => "load_more", "options" => [
        "items_per_page" => 5, "more_button_text" => "Load more", "end_text" => "VLM All caught up",
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view vlm_finish has load_more pager, end_text='VLM All caught up'"
