#!/usr/bin/env bash
# Execution VERIFY: PASS when view st_pos uses simple_timeline AND position_items=right.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("st_pos");
  $s = $v ? ($v->getDisplay("default")["display_options"]["style"] ?? []) : [];
  $type = $s["type"] ?? "none";
  $pos = $s["options"]["position_items"] ?? "none";
  $ok = ($type === "simple_timeline" && $pos === "right");
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($type, TRUE) . " position_items=" . var_export($pos, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
