#!/usr/bin/env bash
# Introspection SETUP: create a View fc_agenda that uses the FullCalendar style with the list
# view enabled, so an agent can identify the calendar style on the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("fc_agenda")) {
    View::create([
      "id" => "fc_agenda", "label" => "FC Agenda", "base_table" => "node_field_data", "base_field" => "nid",
      "display" => ["default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
        "display_options" => ["style" => ["type" => "fullcalendar", "options" => ["list_view" => TRUE]], "row" => ["type" => "fields"]],
      ]],
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: view fc_agenda uses views style fullcalendar (list_view on)"
