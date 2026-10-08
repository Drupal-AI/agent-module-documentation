#!/usr/bin/env bash
# Execution VERIFY: PASS when the masonry_views_task view's default display style plugin is
# 'masonry'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("masonry_views_task");
  $t = $v ? ($v->getDisplay("default")["display_options"]["style"]["type"] ?? "none") : "no-view";
  print (($t === "masonry") ? "PASS" : "FAIL") . " style=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
