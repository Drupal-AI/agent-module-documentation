#!/usr/bin/env bash
# Execution VERIFY: PASS when view vft_task's default display style type is flipped_table.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v=View::load("vft_task");
  $t = $v ? ($v->getDisplay("default")["display_options"]["style"]["type"] ?? "none") : "no-view";
  print (($t==="flipped_table")?"PASS":"FAIL")." style=$t\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
