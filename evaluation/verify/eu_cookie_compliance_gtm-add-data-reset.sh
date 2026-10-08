#!/usr/bin/env bash
# Execution RESET: ensure cookie category eucc_task exists WITHOUT any GTM data, so verify FAILS until
# the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  $c = CookieCategory::load("eucc_task") ?: CookieCategory::create(["id"=>"eucc_task","label"=>"EUCC Task","weight"=>0]);
  $c->unsetThirdPartySetting("eu_cookie_compliance_gtm","gtm_data");
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: cookie category eucc_task has no gtm_data"
