#!/usr/bin/env bash
# Introspection SETUP (popup_field_group): add a Popup group (group_pfg_modal) whose dialog is
# NON-modal (modal=0). Agent must report whether the popup is modal. Config-only. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setThirdPartySetting("field_group", "group_pfg_modal", [
    "label" => "Floating panel", "children" => [], "parent_name" => "", "region" => "content", "weight" => 91,
    "format_type" => "popup",
    "format_settings" => [
      "popup_link" => ["show" => 1, "text" => "Show panel", "classes" => ""],
      "popup_labels" => ["title" => "Panel", "close_text" => "Close"],
      "popup_settings" => ["modal" => 0, "close_on_escape" => 1, "position_horizontal" => "right", "position_vertical" => "top"],
    ],
  ]);
  $fd->save();
' >/dev/null 2>&1 || true
echo "setup: group_pfg_modal popup group with modal=0 (non-modal)"
exit 0
