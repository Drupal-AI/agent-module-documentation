#!/usr/bin/env bash
# Execution VERIFY: PASS when field_rs_task component uses widget type range_slider. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  $c = $fd->getComponent("field_rs_task");
  $type = $c["type"] ?? "none";
  $ok = ($type === "range_slider");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
