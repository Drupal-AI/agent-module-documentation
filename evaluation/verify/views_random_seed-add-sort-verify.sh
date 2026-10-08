#!/usr/bin/env bash
# Execution VERIFY: PASS when the vrs_task view's default display has a sort handler backed by
# the Views random seed plugin (table 'views', field 'random_seed', i.e. the
# views_random_seed_random sort). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vrs_task");
  $found = FALSE;
  if ($v) {
    foreach ($v->get("display") as $display) {
      foreach ($display["display_options"]["sorts"] ?? [] as $s) {
        $isRnd = (($s["plugin_id"] ?? "") === "views_random_seed_random")
          || ((($s["table"] ?? "") === "views") && (($s["field"] ?? "") === "random_seed"));
        if ($isRnd) { $found = TRUE; }
      }
    }
  }
  print ($found ? "PASS" : "FAIL") . " random_seed_sort=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
