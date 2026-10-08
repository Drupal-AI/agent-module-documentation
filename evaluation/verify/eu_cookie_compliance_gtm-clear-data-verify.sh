#!/usr/bin/env bash
# Execution VERIFY: PASS when cookie category eucc_clear no longer has any GTM data configured
# (third-party setting unset / empty). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  $c = CookieCategory::load("eucc_clear");
  $data = $c ? $c->getThirdPartySetting("eu_cookie_compliance_gtm","gtm_data") : "MISSING";
  $ok = ($c && empty($data));
  print ($ok ? "PASS" : "FAIL") . " gtm_data=" . json_encode($data) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
