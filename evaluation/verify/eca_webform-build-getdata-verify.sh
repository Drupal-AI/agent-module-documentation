#!/usr/bin/env bash
# Execution VERIFY: PASS when ECA model ecawf_task exists and at least one action uses the
# eca_webform 'Get submission data' plugin (eca_webform_submission_get_data). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("eca")->load("ecawf_task");
  $found = "";
  if ($e) {
    foreach ($e->get("actions") ?? [] as $a) {
      if (($a["plugin"] ?? "") === "eca_webform_submission_get_data") { $found = $a["plugin"]; break; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " model=" . ($e ? "yes" : "no") . " action=" . ($found ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
