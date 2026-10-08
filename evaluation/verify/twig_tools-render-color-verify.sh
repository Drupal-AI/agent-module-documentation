#!/usr/bin/env bash
# Execution VERIFY: PASS when config twig_tools_eval.result:css == the twig_tools hex_to_css_rgb
# output for #3366cc, i.e. "rgb(51, 102, 204)". Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("twig_tools_eval.result")->get("css");
  $ok = ($v === "rgb(51, 102, 204)");
  print ($ok ? "PASS" : "FAIL") . " css=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
