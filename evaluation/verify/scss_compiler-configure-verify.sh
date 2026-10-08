#!/usr/bin/env bash
# Execution VERIFY: PASS when scss_compiler.settings output_format == expanded AND plugins.less
# == scss_compiler_lessphp. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("scss_compiler.settings");
  $fmt = $c->get("output_format");
  $less = $c->get("plugins.less");
  $ok = ($fmt === "expanded" && $less === "scss_compiler_lessphp");
  print ($ok ? "PASS" : "FAIL") . " output_format=" . var_export($fmt, TRUE) . " plugins.less=" . var_export($less, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
