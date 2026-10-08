#!/usr/bin/env bash
# Execution VERIFY: PASS when view sv_eval_task default display uses style semanticviews_style with
# the row wrapper element set to 'article'. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("sv_eval_task");
  $d = $v ? $v->getDisplay("default")["display_options"] : [];
  $style = $d["style"]["type"] ?? "";
  $rowel = $d["style"]["options"]["row"]["element_type"] ?? "";
  $ok = ($v && $style === "semanticviews_style" && $rowel === "article");
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($style, TRUE) . " row_element=" . var_export($rowel, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
