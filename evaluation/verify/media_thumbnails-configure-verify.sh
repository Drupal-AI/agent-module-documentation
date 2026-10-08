#!/usr/bin/env bash
# Execution VERIFY: PASS when media_thumbnails.settings has width 250, bgcolor_active TRUE and
# bgcolor_value #123456. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("media_thumbnails.settings");
  $w = $c->get("width"); $a = $c->get("bgcolor_active"); $v = $c->get("bgcolor_value");
  $ok = ((int) $w === 250) && ((bool) $a === TRUE) && (strtolower((string) $v) === "#123456");
  print ($ok ? "PASS" : "FAIL") . " width=" . var_export($w, TRUE)
    . " bgcolor_active=" . var_export($a, TRUE) . " bgcolor_value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
