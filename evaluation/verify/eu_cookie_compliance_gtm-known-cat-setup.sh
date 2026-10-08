#!/usr/bin/env bash
# Introspection SETUP: create a cookie category eucc_analytics carrying GTM data {"analytics":"@status"}
# so an agent can discover which category pushes data to GTM. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  $c = CookieCategory::load("eucc_analytics") ?: CookieCategory::create(["id"=>"eucc_analytics","label"=>"EUCC Analytics","weight"=>0]);
  $c->setThirdPartySetting("eu_cookie_compliance_gtm","gtm_data",["analytics"=>"@status"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cookie category eucc_analytics gtm_data={\"analytics\":\"@status\"}"
