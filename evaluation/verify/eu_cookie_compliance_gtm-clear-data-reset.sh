#!/usr/bin/env bash
# Execution RESET: ensure cookie category eucc_clear exists WITH GTM data set, so verify FAILS until
# the agent removes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  $c = CookieCategory::load("eucc_clear") ?: CookieCategory::create(["id"=>"eucc_clear","label"=>"EUCC Clear","weight"=>0]);
  $c->setThirdPartySetting("eu_cookie_compliance_gtm","gtm_data",["analytics"=>"@status"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cookie category eucc_clear has gtm_data set"
