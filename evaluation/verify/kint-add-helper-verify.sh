#!/usr/bin/env bash
# Execution VERIFY: PASS when config kint.helper.kdd exists with mode 'exit' and a Rich renderer.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("kint.helper.kdd");
  $mode = $c->get("mode");
  $renderer = (string) $c->get("renderer");
  $ok = ($mode === "exit") && (strpos($renderer, "RichRenderer") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " mode=" . var_export($mode, TRUE) . " renderer=" . $renderer . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
