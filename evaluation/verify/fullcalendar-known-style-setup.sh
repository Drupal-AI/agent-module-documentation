#!/usr/bin/env bash
# Introspection SETUP: create a View fc_events of content that uses the FullCalendar Views style
# so an agent can inspect the running site and report the style plugin id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("fc_events")) {
    View::create([
      "id" => "fc_events", "label" => "FC Events", "base_table" => "node_field_data", "base_field" => "nid",
      "display" => ["default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["style" => ["type" => "fullcalendar", "options" => []], "row" => ["type" => "fields"]],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view fc_events uses views style fullcalendar"
