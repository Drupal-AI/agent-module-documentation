#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ecf_str uses wrapper_class with class containing "callout". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")->getComponent("field_ecf_str");
  $type = $c["type"] ?? "none"; $class = $c["settings"]["class"] ?? "";
  $ok = ($type === "wrapper_class") && (strpos($class, "callout") !== false);
  print ($ok ? "PASS" : "FAIL") . " type=$type class=\"$class\"\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
