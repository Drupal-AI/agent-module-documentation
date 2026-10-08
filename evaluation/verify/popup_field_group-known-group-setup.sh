#!/usr/bin/env bash
# Introspection SETUP (popup_field_group): add a Popup field group (group_pfg_known) to the
# Article default FORM display, so an agent can read back its formatter and settings.
# Config save on a display entity (no router rebuild). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setThirdPartySetting("field_group", "group_pfg_known", [
    "label" => "Extra details", "children" => [], "parent_name" => "", "region" => "content", "weight" => 90,
    "format_type" => "popup",
    "format_settings" => [
      "popup_link" => ["show" => 1, "text" => "Open the gallery", "classes" => ""],
      "popup_labels" => ["title" => "Gallery", "close_text" => "Close"],
      "popup_settings" => ["modal" => 1, "close_on_escape" => 1, "position_horizontal" => "center", "position_vertical" => "center"],
    ],
  ]);
  $fd->save();
' >/dev/null 2>&1 || true
echo "setup: node.article default form display has popup group group_pfg_known (link text 'Open the gallery')"
exit 0
