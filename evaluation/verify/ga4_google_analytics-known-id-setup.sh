#!/usr/bin/env bash
# Introspection SETUP: write a known ga4_google_analytics.config so an inspecting agent can
# read back the configured Measurement ID. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ga4_google_analytics.config");
  $c->set("measurement_id", "G-DEMO7A4B2C");
  $c->set("scripts_custom_attributes", "");
  $c->set("ga4_access_roles", []);
  $c->set("ga4_access_pages", ["id" => "request_path", "negate" => FALSE, "pages" => ""]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ga4_google_analytics.config measurement_id=G-DEMO7A4B2C"
