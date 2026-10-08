#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ifs_task's component on node.article.default uses the
# imagefield_slideshow_field_formatter. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $d ? $d->getComponent("field_ifs_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "imagefield_slideshow_field_formatter");
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
