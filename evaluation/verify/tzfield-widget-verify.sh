#!/usr/bin/env bash
# Execution VERIFY (tzfield widget): PASS when field_tz_widget on Article uses the tzfield_offset
# widget in the default form display. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_tz_widget") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "tzfield_offset");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
