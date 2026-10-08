#!/usr/bin/env bash
# Execution VERIFY: PASS when the google_v3 translator tmgmtg_cfg has a non-empty api_project
# (Google Cloud project id) set. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tmgmtg_cfg");
  $plugin = $t ? $t->getPluginId() : "none";
  $proj = $t ? (string) $t->getSetting("api_project") : "";
  $ok = ($t && $plugin === "google_v3" && $proj !== "");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " api_project=" . var_export($proj, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
