#!/usr/bin/env bash
# Live-state verification for the "build a SCHEDULED sitewide alert" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a sitewide_alert entity exists that is ACTIVE, has scheduling enabled
# (scheduled_alert = TRUE) with both a start (value) and end (end_value) on scheduled_date,
# and whose message contains the required registration text.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $needle = "registration is now open";
  $s = \Drupal::entityTypeManager()->getStorage("sitewide_alert");
  $hit = FALSE;
  foreach ($s->loadMultiple() as $a) {
    $msg = (string) ($a->get("message")->value ?? "");
    $active = (int) $a->get("status")->value === 1;
    $sched = (bool) $a->get("scheduled_alert")->value;
    $start = $a->get("scheduled_date")->value ?? "";
    $end = $a->get("scheduled_date")->end_value ?? "";
    if (stripos($msg, $needle) !== FALSE && $active && $sched && $start !== "" && $end !== "") { $hit = TRUE; }
  }
  print ($hit ? "PASS" : "FAIL") . " match_active_scheduled_daterange=" . ($hit?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
