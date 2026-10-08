#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH the core FullCalendar script AND the Scheduler add-on script
# resolve to LOCAL /libraries paths (not the CDN). Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ld = \Drupal::service("library.discovery");
  $ld->clearCachedDefinitions();
  $core = $ld->getLibraryByName("fullcalendar_library", "fullcalendar");
  $sched = $ld->getLibraryByName("fullcalendar_library", "fullcalendar-scheduler");
  $cj = implode(" ", array_map(function ($j) { return $j["data"] ?? ""; }, $core["js"] ?? []));
  $sj = implode(" ", array_map(function ($j) { return $j["data"] ?? ""; }, $sched["js"] ?? []));
  $ok = (strpos($cj, "libraries/fullcalendar/fullcalendar.min.js") !== FALSE)
    && (strpos($sj, "libraries/fullcalendar-scheduler/scheduler.min.js") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " core=" . $cj . " sched=" . $sj . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
