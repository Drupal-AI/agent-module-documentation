#!/usr/bin/env bash
# Execution VERIFY: PASS when autologout is enabled (enable=1) AND the default timeout is 600
# seconds. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("inactive_autologout.settings");
  $en = $c->get("enable");
  $to = $c->get("timeout");
  $ok = (!empty($en) && (int) $to === 600);
  print ($ok ? "PASS" : "FAIL") . " enable=" . var_export($en, TRUE) . " timeout=" . var_export($to, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
