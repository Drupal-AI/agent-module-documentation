#!/usr/bin/env bash
# Execution VERIFY: PASS when the tome_ssc_probe view's default display uses the
# tome_static_super_cache_smart_tag cache plugin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("tome_ssc_probe");
  $type = $v ? ($v->get("display")["default"]["display_options"]["cache"]["type"] ?? "none") : "missing";
  print (($type === "tome_static_super_cache_smart_tag") ? "PASS" : "FAIL") . " cache_type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
