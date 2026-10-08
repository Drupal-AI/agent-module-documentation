#!/usr/bin/env bash
# HARD execution verify: a Google Programmable Search page must exist and be configured with
# the requested dummy Search Engine ID and on-site results options. Prints PASS/FAIL, exits
# 0 (pass) / 1 (fail). Reads config directly from the search.page config entity (google_cse
# has NO settings object; its config lives in search.page.<id>.configuration.*).
# Live search results need a real Google engine — NOT checked here; this verifies CONFIG only.
# Checks (over any google_cse_search page, id-independent):
#   cx   — configuration.cx == the requested dummy id  eval-demo-000111:dummyengine
#   disp — configuration.results_display == 'here' (results rendered on this site)
#   lay  — configuration.custom_results_display == 'results-only'
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cx = FALSE; $disp = FALSE; $lay = FALSE; $found = FALSE;
  foreach (\Drupal::entityTypeManager()->getStorage("search_page")->loadMultiple() as $p) {
    if ($p->getPlugin()->getPluginId() !== "google_cse_search") { continue; }
    $found = TRUE;
    $c = $p->getPlugin()->getConfiguration();
    if (($c["cx"] ?? "") === "eval-demo-000111:dummyengine") { $cx = TRUE; }
    if (($c["results_display"] ?? "") === "here") { $disp = TRUE; }
    if (($c["custom_results_display"] ?? "") === "results-only") { $lay = TRUE; }
  }
  $ok = $found && $cx && $disp && $lay;
  print ($ok ? "PASS" : "FAIL") . " found=" . ($found?1:0) . " cx=" . ($cx?1:0) . " disp=" . ($disp?1:0) . " lay=" . ($lay?1:0) . "\n";
' 2>/dev/null | grep -Ev '^\s*(Deprecated|Warning|Notice):' | grep -E '^(PASS|FAIL)')

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
