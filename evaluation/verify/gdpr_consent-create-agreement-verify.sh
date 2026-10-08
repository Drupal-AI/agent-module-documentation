#!/usr/bin/env bash
# Execution VERIFY: PASS when a gdpr_consent_agreement titled 'GDPR Eval Task' exists.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("gdpr_consent_agreement");
  $found = $s->loadByProperties(["title" => "GDPR Eval Task"]);
  $ok = (count($found) > 0);
  $mode = "none";
  if ($ok) { $e = reset($found); $mode = $e->get("mode")->value; }
  print ($ok ? "PASS" : "FAIL") . " count=" . count($found) . " mode=" . $mode . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
