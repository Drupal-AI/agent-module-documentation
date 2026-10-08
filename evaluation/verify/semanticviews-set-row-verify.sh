#!/usr/bin/env bash
# Execution VERIFY: PASS when view sv_eval_rowtask default display uses the semanticviews_row row
# plugin. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("sv_eval_rowtask");
  $d = $v ? $v->getDisplay("default")["display_options"] : [];
  $rowtype = $d["row"]["type"] ?? "";
  $ok = ($v && $rowtype === "semanticviews_row");
  print ($ok ? "PASS" : "FAIL") . " row_plugin=" . var_export($rowtype, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
