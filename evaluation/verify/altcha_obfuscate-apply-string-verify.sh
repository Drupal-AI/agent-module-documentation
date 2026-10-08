#!/usr/bin/env bash
# hard VERIFY (altcha_obfuscate): PASS when field_aobf_task's view-display formatter is
# altcha_obfuscated_string. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_aobf_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "altcha_obfuscated_string");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
