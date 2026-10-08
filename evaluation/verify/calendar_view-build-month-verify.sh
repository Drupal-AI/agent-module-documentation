#!/usr/bin/env bash
# Live-state verification for "build a monthly Calendar View" task.
# PASS if View `cv_hard_month` exists and one of its displays uses the calendar_month
# style plugin with a non-empty calendar_fields (a date field bound to the calendar).
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("cv_hard_month");
  $pass = FALSE; $style = ""; $fields = "";
  if ($v) {
    foreach ($v->get("display") as $display) {
      $opts = $display["display_options"]["style"] ?? [];
      $type = $opts["type"] ?? "";
      $cf = array_filter($opts["options"]["calendar_fields"] ?? [], function ($x) { return !empty($x) && $x !== 0; });
      if ($type === "calendar_month" && !empty($cf)) {
        $pass = TRUE; $style = $type; $fields = implode(",", array_keys($cf));
      }
    }
  }
  print ($pass ? "PASS" : "FAIL") . " view=" . ($v ? 1 : 0) . " style=" . $style . " fields=" . $fields . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
