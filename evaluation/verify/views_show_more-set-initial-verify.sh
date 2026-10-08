#!/usr/bin/env bash
# Execution VERIFY: PASS when view vsm_eval_initial uses the show_more pager with initial === 10. 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vsm_eval_initial");
  $d = $v ? $v->getDisplay("default")["display_options"] : [];
  $pager = $d["pager"]["type"] ?? "";
  $initial = $d["pager"]["options"]["initial"] ?? NULL;
  $ok = ($v && $pager === "show_more" && (int) $initial === 10);
  print ($ok ? "PASS" : "FAIL") . " pager=" . var_export($pager, TRUE) . " initial=" . var_export($initial, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
