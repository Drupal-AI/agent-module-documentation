#!/usr/bin/env bash
# Execution VERIFY: PASS when /tmp/scss_compiler-eval/style.css exists and contains the compiled
# nested selector ".box .title" and the brand color "#123456". Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = "/tmp/scss_compiler-eval/style.css";
  $css = file_exists($f) ? file_get_contents($f) : "";
  $sel = (strpos($css, ".box .title") !== FALSE);
  $col = (stripos($css, "#123456") !== FALSE);
  $ok = ($sel && $col);
  print ($ok ? "PASS" : "FAIL") . " exists=" . (file_exists($f)?"y":"n") . " selector=" . ($sel?"y":"n") . " color=" . ($col?"y":"n") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
