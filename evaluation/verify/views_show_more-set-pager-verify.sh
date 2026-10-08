#!/usr/bin/env bash
# Execution VERIFY: PASS when view vsm_eval_task default display uses the show_more pager. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vsm_eval_task");
  $d = $v ? $v->getDisplay("default")["display_options"] : [];
  $pager = $d["pager"]["type"] ?? "";
  $ok = ($v && $pager === "show_more");
  print ($ok ? "PASS" : "FAIL") . " pager=" . var_export($pager, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
