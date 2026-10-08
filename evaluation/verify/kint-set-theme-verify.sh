#!/usr/bin/env bash
# Execution VERIFY: PASS when kint.settings rich_theme is aante-dark.css and date_format is [Y-m-d].
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("kint.settings");
  $theme = (string) $c->get("rich_theme");
  $fmt = (string) $c->get("date_format");
  $ok = ($theme === "aante-dark.css") && ($fmt === "[Y-m-d]");
  print ($ok ? "PASS" : "FAIL") . " rich_theme=" . $theme . " date_format=" . $fmt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
