#!/usr/bin/env bash
# Execution RESET: create ga4_google_analytics.config with a Measurement ID but NO page
# restriction (pages empty, negate false => tracks everywhere), so verify FAILS until the agent
# restricts tracking to /blog. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ga4_google_analytics.config");
  $c->set("measurement_id", "G-BLOG00BASE");
  $c->set("scripts_custom_attributes", "");
  $c->set("ga4_access_roles", []);
  $c->set("ga4_access_pages", ["id" => "request_path", "negate" => FALSE, "pages" => ""]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ga4_google_analytics.config present, no page restriction"
