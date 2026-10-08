#!/usr/bin/env bash
# Execution VERIFY: PASS when the vrs_task2 view's Random seed sort has reset_seed_int == 86400
# (reshuffle daily). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vrs_task2");
  $val = NULL;
  if ($v) {
    foreach ($v->get("display") as $display) {
      foreach ($display["display_options"]["sorts"] ?? [] as $s) {
        $isRnd = (($s["plugin_id"] ?? "") === "views_random_seed_random")
          || ((($s["table"] ?? "") === "views") && (($s["field"] ?? "") === "random_seed"));
        if ($isRnd) { $val = $s["reset_seed_int"] ?? NULL; }
      }
    }
  }
  $ok = ((int) $val === 86400);
  print ($ok ? "PASS" : "FAIL") . " reset_seed_int=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
