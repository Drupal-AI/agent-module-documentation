#!/usr/bin/env bash
# Execution VERIFY: PASS when a TMGMT Translator named tmgmtg_task exists and uses the google_v3
# plugin. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tmgmtg_task");
  $plugin = $t ? $t->getPluginId() : "none";
  $ok = ($t && $plugin === "google_v3");
  print ($ok ? "PASS" : "FAIL") . " translator=" . ($t ? "tmgmtg_task" : "missing") . " plugin=" . $plugin . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
