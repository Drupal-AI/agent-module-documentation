#!/usr/bin/env bash
# Execution VERIFY: PASS when the resolved 'fullcalendar_library/fullcalendar' library serves
# fullcalendar.min.js from a LOCAL /libraries path (not the CDN). Prints PASS/FAIL.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("library.discovery")->clearCachedDefinitions();
  $lib = \Drupal::service("library.discovery")->getLibraryByName("fullcalendar_library", "fullcalendar");
  $datas = array_map(function ($j) { return $j["data"] ?? ""; }, $lib["js"] ?? []);
  $joined = implode(" ", $datas);
  $local = (strpos($joined, "libraries/fullcalendar/fullcalendar.min.js") !== FALSE);
  print ($local ? "PASS" : "FAIL") . " js=" . $joined . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
