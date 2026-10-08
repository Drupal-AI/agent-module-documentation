#!/usr/bin/env bash
# Execution VERIFY: PASS when pager_label === 'meta' AND current_page_label === 'page'.
# Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("pager_serializer.settings");
  $pl = (string) $c->get("pager_label");
  $cp = (string) $c->get("current_page_label");
  $ok = ($pl === "meta" && $cp === "page");
  print ($ok ? "PASS" : "FAIL") . " pager_label=" . var_export($pl, TRUE) . " current_page_label=" . var_export($cp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
