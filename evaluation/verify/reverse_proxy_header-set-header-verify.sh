#!/usr/bin/env bash
# Execution VERIFY: PASS when Settings::get('reverse_proxy_header') === 'HTTP_X_RPH_TASK_HEADER'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\Core\Site\Settings::get("reverse_proxy_header");
  $ok = ($v === "HTTP_X_RPH_TASK_HEADER");
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
