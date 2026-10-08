#!/usr/bin/env bash
# Execution VERIFY: PASS when view st_task's default display uses the simple_timeline style.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("st_task");
  $type = $v ? ($v->getDisplay("default")["display_options"]["style"]["type"] ?? "none") : "no-view";
  $ok = ($type === "simple_timeline");
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
