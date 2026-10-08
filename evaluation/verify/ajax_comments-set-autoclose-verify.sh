#!/usr/bin/env bash
# Execution VERIFY: PASS when reply_autoclose===true AND notify===false. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("ajax_comments.settings");
  $ra = $c->get("reply_autoclose"); $n = $c->get("notify");
  $ok = ($ra === TRUE && $n === FALSE);
  print ($ok ? "PASS" : "FAIL") . " reply_autoclose=" . var_export($ra, TRUE) . " notify=" . var_export($n, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
