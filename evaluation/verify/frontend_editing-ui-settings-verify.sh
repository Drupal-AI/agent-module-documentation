#!/usr/bin/env bash
# Execution VERIFY: PASS when frontend_editing.settings has sidebar_width===40 AND
# automatic_preview===true. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("frontend_editing.settings");
  $w = $c->get("sidebar_width"); $p = $c->get("automatic_preview");
  $ok = ((int) $w === 40) && ($p === TRUE);
  print ($ok ? "PASS" : "FAIL") . " sidebar_width=" . var_export($w, TRUE) . " automatic_preview=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
