#!/usr/bin/env bash
# Execution VERIFY: PASS when cookie category eucc_task has gtm_data that is a JSON object mapping
# key 'analytics' to the token '@status'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\eu_cookie_compliance\Entity\CookieCategory;
  $c = CookieCategory::load("eucc_task");
  $data = $c ? $c->getThirdPartySetting("eu_cookie_compliance_gtm","gtm_data") : NULL;
  $ok = is_array($data) && isset($data["analytics"]) && $data["analytics"] === "@status";
  print ($ok ? "PASS" : "FAIL") . " gtm_data=" . json_encode($data) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
