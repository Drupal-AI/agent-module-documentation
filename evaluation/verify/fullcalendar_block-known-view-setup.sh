#!/usr/bin/env bash
# Introspection SETUP: place a FullCalendar block (id fcb_view) with a non-default initial view. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("fcb_view")) { $b->delete(); }
  Block::create([
    "id" => "fcb_view", "theme" => $theme, "region" => "content", "weight" => -19,
    "plugin" => "fullcalendar_block",
    "settings" => ["id" => "fullcalendar_block", "label" => "View Calendar", "label_display" => "0",
      "event_source" => "/fcb-view-feed", "initial_view" => "timeGridWeek"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
echo "setup: block fcb_view placed with initial_view=timeGridWeek"
