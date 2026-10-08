#!/usr/bin/env bash
# Execution VERIFY: PASS when contact_message_feedback_form is in the additional submittable list.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("readonlymode.settings")->get("forms.additional.edit");
  $ok = str_contains($v, "contact_message_feedback_form");
  print ($ok ? "PASS" : "FAIL") . " additional_edit=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
