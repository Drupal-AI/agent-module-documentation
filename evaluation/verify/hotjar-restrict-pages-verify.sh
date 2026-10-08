#!/usr/bin/env bash
# Execution VERIFY: PASS when Hotjar is set to track ONLY the listed pages (visibility_pages==1)
# and the pages list contains /landing. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("hotjar.settings");
  $vis = (int) $c->get("visibility_pages");
  $pages = (string) $c->get("pages");
  $ok = ($vis === 1) && (strpos($pages, "/landing") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " visibility_pages=" . $vis . " has_landing=" . (strpos($pages, "/landing") !== FALSE ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
