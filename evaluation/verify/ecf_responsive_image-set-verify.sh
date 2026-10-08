#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ecfri_pic uses responsive_image_class with class containing "hero-img".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")->getComponent("field_ecfri_pic");
  $type = $c["type"] ?? "none"; $class = $c["settings"]["class"] ?? "";
  $ok = ($type === "responsive_image_class") && (strpos($class, "hero-img") !== false);
  print ($ok ? "PASS" : "FAIL") . " type=$type class=\"$class\"\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
