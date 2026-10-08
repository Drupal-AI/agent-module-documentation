#!/usr/bin/env bash
# Execution VERIFY: PASS when general.protected_ids contains contact_message_feedback_form and
# protect_all is not enabled. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("protect_form_flood_control.settings");
  $ids = $c->get("general.protected_ids") ?: [];
  $pa = $c->get("general.protect_all");
  $ok = in_array("contact_message_feedback_form", $ids, TRUE) && !$pa;
  print ($ok ? "PASS" : "FAIL") . " protected_ids=" . json_encode($ids) . " protect_all=" . var_export($pa, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
