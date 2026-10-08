#!/usr/bin/env bash
# Execution VERIFY: PASS when sticky.settings has selector '.site-header' and top_spacing 30
# (stored as int). Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("sticky.settings");
  $sel = $c->get("selector");
  $top = $c->get("top_spacing");
  $ok = ($sel === ".site-header" && (int) $top === 30);
  print ($ok ? "PASS" : "FAIL") . " selector=" . var_export($sel, TRUE) . " top_spacing=" . var_export($top, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
