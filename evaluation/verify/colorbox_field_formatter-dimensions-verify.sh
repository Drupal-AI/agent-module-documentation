#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cff_dim on the Article default view display uses a Colorbox
# formatter with popup width 900 AND iframe mode enabled. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $d ? $d->getComponent("field_cff_dim") : NULL;
  $w = $c["settings"]["width"] ?? NULL;
  $if = $c["settings"]["iframe"] ?? NULL;
  $type = $c["type"] ?? "none";
  $ok = (strpos($type, "colorbox_field_formatter") === 0 && $w == 900 && !empty($if));
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . " width=" . var_export($w, TRUE) . " iframe=" . var_export($if, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
