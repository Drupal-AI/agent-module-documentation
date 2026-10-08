#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article node titled "DAD Build All Day" exists whose
# field_dad_build value is on 2026-12-24 and is recognised as all-day by the module's own
# helper, DateRangeAllDayHelper::isAllDay(). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\date_all_day\Utility\DateRangeAllDayHelper;
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "DAD Build All Day"]);
  if (!$nodes) { print "FAIL no node titled \"DAD Build All Day\"\n"; return; }
  $node = reset($nodes);
  if ($node->get("field_dad_build")->isEmpty()) { print "FAIL field_dad_build is empty\n"; return; }
  $item = $node->get("field_dad_build")->get(0);
  $allDay = DateRangeAllDayHelper::isAllDay($item);
  $tz = date_default_timezone_get();
  $start = $item->start_date ? $item->start_date->format("Y-m-d", ["timezone" => $tz]) : "none";
  $ok = $allDay && ($start === "2026-12-24");
  print ($ok ? "PASS" : "FAIL") . " isAllDay=" . var_export($allDay, TRUE)
    . " start_local=" . $start
    . " raw=" . $item->value . "/" . ($item->end_value ?? "NULL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
