#!/usr/bin/env bash
# Execution VERIFY: PASS when config colorapi.colorapi_color.cai_red exists with color '#FF0000'.
# Reads raw config so it works regardless of whether the entity type is registered.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("colorapi.colorapi_color.cai_red");
  $color = $c->get("color");
  $label = $c->get("label");
  $ok = (strtoupper((string) $color) === "#FF0000");
  print ($ok ? "PASS" : "FAIL") . " color=" . var_export($color, TRUE) . " label=" . var_export($label, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
