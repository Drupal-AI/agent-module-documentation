#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cff_task on the Article default view display uses a Colorbox
# field formatter (type starts with colorbox_field_formatter). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $d ? $d->getComponent("field_cff_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = (strpos($type, "colorbox_field_formatter") === 0);
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
