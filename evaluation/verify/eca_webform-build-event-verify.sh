#!/usr/bin/env bash
# Execution VERIFY: PASS when ECA model ecawf_task2 exists and starts from an eca_webform
# submission-form-alter event (plugin webform:submission_form_alter). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("eca")->load("ecawf_task2");
  $found = "";
  if ($e) {
    foreach ($e->get("events") ?? [] as $ev) {
      if (($ev["plugin"] ?? "") === "webform:submission_form_alter") { $found = $ev["plugin"]; break; }
    }
  }
  print ($found ? "PASS" : "FAIL") . " model=" . ($e ? "yes" : "no") . " event=" . ($found ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
