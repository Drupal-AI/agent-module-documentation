#!/usr/bin/env bash
# Introspection SETUP: insert a known GA field row into the google_analytics_reports_fields table
# (as the Import fields batch would) so an agent can inspect the imported-field catalogue and
# report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  $db->merge("google_analytics_reports_fields")
    ->key("gaid", "gar_known_sessions")
    ->fields([
      "type" => "METRIC", "data_type" => "INTEGER", "column_group" => "GAR Test",
      "ui_name" => "GAR Known Sessions", "description" => "Test metric", "calculation" => "",
    ])->execute();
' >/dev/null 2>&1
echo "setup: google_analytics_reports_fields has gaid=gar_known_sessions (ui_name 'GAR Known Sessions')"
