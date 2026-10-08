#!/usr/bin/env bash
# Introspection SETUP: write a known ga4_google_analytics.config whose tracking is restricted to
# a single role and excludes admin/user paths, so an agent can read back the scope. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ga4_google_analytics.config");
  $c->set("measurement_id", "G-SCOPE9Z1Q");
  $c->set("scripts_custom_attributes", "");
  $c->set("ga4_access_roles", ["administrator"]);
  $c->set("ga4_access_pages", ["id" => "request_path", "negate" => TRUE, "pages" => "/admin/*\n/user/*"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ga4_google_analytics.config roles=[administrator] pages excluded /admin/* /user/*"
