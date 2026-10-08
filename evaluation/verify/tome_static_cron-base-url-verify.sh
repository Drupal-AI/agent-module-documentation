#!/usr/bin/env bash
# Execution VERIFY: PASS when tome_static_cron.settings has a non-empty, valid base_url.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = \Drupal::config("tome_static_cron.settings")->get("base_url");
  $ok = is_string($u) && $u !== "" && \Drupal\Component\Utility\UrlHelper::isValid($u, TRUE);
  print ($ok ? "PASS" : "FAIL") . " base_url=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
