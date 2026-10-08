#!/usr/bin/env bash
# Execution VERIFY: PASS when a View fc_cal exists with at least one display using the
# fullcalendar Views style. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("fc_cal");
  $hit = "none";
  if ($v) {
    foreach ($v->get("display") as $id => $d) {
      $t = $d["display_options"]["style"]["type"] ?? NULL;
      if ($t === "fullcalendar") { $hit = $id; break; }
    }
  }
  print (($hit !== "none") ? "PASS" : "FAIL") . " view=" . ($v ? "fc_cal" : "missing") . " fullcalendar_display=" . $hit . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
