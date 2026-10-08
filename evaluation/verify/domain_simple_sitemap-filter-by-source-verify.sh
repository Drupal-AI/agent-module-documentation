#!/usr/bin/env bash
# Execution VERIFY: PASS when domain_simple_sitemap_filter is truthy (1/TRUE). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("domain_simple_sitemap.settings")->get("domain_simple_sitemap_filter");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok?"PASS":"FAIL")." domain_simple_sitemap_filter=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
