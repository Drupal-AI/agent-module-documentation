#!/usr/bin/env bash
# Execution VERIFY: PASS when view vsnf_task default display has a sort with plugin_id null_sort and
# order ASC (NULL last). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vsnf_task");
  $ok = FALSE; $found = "none";
  if ($v) {
    $disp = $v->get("display");
    $sorts = $disp["default"]["display_options"]["sorts"] ?? [];
    foreach ($sorts as $s) {
      if (($s["plugin_id"] ?? "") === "null_sort") {
        $found = strtoupper($s["order"] ?? "");
        if ($found === "ASC") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " null_sort_order=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
