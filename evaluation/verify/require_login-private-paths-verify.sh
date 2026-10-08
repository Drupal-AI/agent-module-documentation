#!/usr/bin/env bash
# Execution VERIFY: PASS when the request_path requirement limits login to /private paths
# (pages contains '/private/*' and '/private') with negate FALSE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("require_login.settings");
  $rp = $c->get("requirements.request_path") ?? [];
  $pages = (string) ($rp["pages"] ?? "");
  $negate = $rp["negate"] ?? NULL;
  $ok = (strpos($pages, "/private/*") !== FALSE) && (strpos($pages, "/private") !== FALSE) && ($negate === FALSE);
  print ($ok ? "PASS" : "FAIL") . " negate=" . var_export($negate, TRUE) . " pages=" . json_encode($pages) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
