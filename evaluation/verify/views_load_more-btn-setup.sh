#!/usr/bin/env bash
# Introspection SETUP: create a view vlm_known that uses the Views Load More pager with a
# known button label, so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $s->load("vlm_known")) { $v->delete(); }
  $s->create([
    "id" => "vlm_known", "label" => "VLM Known", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["pager" => ["type" => "load_more", "options" => [
        "items_per_page" => 5, "more_button_text" => "VLM Show older items", "end_text" => "",
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "setup: view vlm_known has load_more pager, more_button_text='VLM Show older items'"
