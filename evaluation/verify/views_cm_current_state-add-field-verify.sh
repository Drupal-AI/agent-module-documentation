#!/usr/bin/env bash
# Execution VERIFY: PASS when view vccs_task's default display has a field whose plugin_id is
# current_state_views_field. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vccs_task");
  $ok = FALSE; $found = "none";
  if ($v) {
    $d = $v->getDisplay("default");
    foreach ($d["display_options"]["fields"] ?? [] as $key => $f) {
      if (($f["plugin_id"] ?? "") === "current_state_views_field") { $ok = TRUE; $found = $key; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " field=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
