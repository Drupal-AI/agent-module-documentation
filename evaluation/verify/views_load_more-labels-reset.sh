#!/usr/bin/env bash
# Execution RESET: create/replace view vlm_labels using the load_more pager but with default
# button text and NO finished text, so verify FAILS until the agent sets the custom labels.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $s->load("vlm_labels")) { $v->delete(); }
  $s->create([
    "id" => "vlm_labels", "label" => "VLM Labels", "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => ["pager" => ["type" => "load_more", "options" => [
        "items_per_page" => 10, "more_button_text" => "Load more", "end_text" => "",
      ]]],
    ]],
  ])->save();
' >/dev/null 2>&1
echo "reset: view vlm_labels uses load_more with default button text and empty end_text"
