#!/usr/bin/env bash
# Introspection SETUP: create embed button vee_known (embed_views) restricted to the 'content' View.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("embed_button");
  if ($b = $s->load("vee_known")) { $b->delete(); }
  $s->create([
    "id" => "vee_known", "label" => "VEE Known", "type_id" => "embed_views",
    "type_settings" => ["filter_views" => 1, "views_options" => ["content" => "content"], "filter_displays" => 0, "display_options" => []],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: embed.button.vee_known (embed_views) restricted to views_options=[content]"
