#!/usr/bin/env bash
# Execution VERIFY: PASS when a PUBLISHED llms_txt_section titled 'API Reference' exists.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $matches = \Drupal::entityTypeManager()->getStorage("llms_txt_section")->loadByProperties(["title"=>"API Reference"]);
  $published = 0;
  foreach ($matches as $s) { if ((bool) $s->get("status")->value) { $published++; } }
  $ok = $published >= 1;
  print ($ok ? "PASS" : "FAIL") . " published_api_reference_sections=" . $published . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
