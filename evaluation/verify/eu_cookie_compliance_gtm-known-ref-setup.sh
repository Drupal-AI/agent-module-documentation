#!/usr/bin/env bash
# Introspection SETUP: create a cookie category eucc_marketing whose GTM data references another
# category via @functional_status, so an agent can read that cross-category token. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  $c = CookieCategory::load("eucc_marketing") ?: CookieCategory::create(["id"=>"eucc_marketing","label"=>"EUCC Marketing","weight"=>0]);
  $c->setThirdPartySetting("eu_cookie_compliance_gtm","gtm_data",["marketing"=>"@status","functional"=>"@functional_status"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cookie category eucc_marketing gtm_data references @functional_status"
