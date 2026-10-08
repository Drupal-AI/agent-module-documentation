#!/usr/bin/env bash
# PASS when field_owl_slide uses owlcarousel_field_formatter with loop enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")->getComponent("field_owl_slide");
  $type = $c["type"] ?? "none"; $loop = !empty($c["settings"]["loop"]);
  $ok = ($type === "owlcarousel_field_formatter") && $loop;
  print ($ok ? "PASS" : "FAIL") . " type=$type loop=" . var_export($loop, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
