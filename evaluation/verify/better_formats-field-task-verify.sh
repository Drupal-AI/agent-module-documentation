#!/usr/bin/env bash
# Execution VERIFY: PASS when field_bf_task has better_formats limiting allowed formats to
# EXACTLY basic_html (allowed_formats_toggle TRUE + only basic_html enabled). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_bf_task");
  $tp = $fc ? $fc->getThirdPartySettings("better_formats") : [];
  $toggle = $tp["allowed_formats_toggle"] ?? NULL;
  $af = $tp["allowed_formats"] ?? [];
  $enabled = [];
  foreach ($af as $k => $v) {
    if ($v) { $enabled[] = (is_string($k) && !ctype_digit((string) $k)) ? $k : $v; }
  }
  $enabled = array_values(array_unique($enabled));
  $ok = ($toggle === TRUE) && ($enabled === ["basic_html"]);
  print (($ok) ? "PASS" : "FAIL") . " toggle=" . var_export($toggle, TRUE) . " enabled=" . implode(",", $enabled) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
