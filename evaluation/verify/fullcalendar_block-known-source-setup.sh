#!/usr/bin/env bash
# Introspection SETUP: place a FullCalendar block (id fcb_known) in the default theme's content region with
# a known event source, so an agent can find it and read the feed URL. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("fcb_known")) { $b->delete(); }
  Block::create([
    "id" => "fcb_known", "theme" => $theme, "region" => "content", "weight" => -20,
    "plugin" => "fullcalendar_block",
    "settings" => ["id" => "fullcalendar_block", "label" => "Known Calendar", "label_display" => "0",
      "event_source" => "/fcb-known-feed", "initial_view" => "dayGridMonth"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: block fcb_known placed with event_source=/fcb-known-feed"
