#!/usr/bin/env bash
# Execution VERIFY: PASS when vri_task_view default display style type === row_insert.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vri_task_view");
  $t = $v ? ($v->getDisplay("default")["display_options"]["style"]["type"] ?? "none") : "noview";
  print (($t === "row_insert") ? "PASS" : "FAIL") . " style=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
