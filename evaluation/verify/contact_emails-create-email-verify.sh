#!/usr/bin/env bash
# Execution VERIFY: PASS when a contact_email for ce_task exists with recipients containing
# ops@ce-task.example and status enabled. Read-only. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("contact_email");
  $ids = \Drupal::entityQuery("contact_email")->accessCheck(FALSE)->condition("contact_form", "ce_task")->execute();
  $found = FALSE; $seen = [];
  foreach ($storage->loadMultiple($ids) as $e) {
    $r = (string) $e->get("recipients")->value;
    $en = (bool) $e->get("status")->value;
    $seen[] = $r . ($en ? "" : "(disabled)");
    if (strpos($r, "ops@ce-task.example") !== FALSE && $en) { $found = TRUE; }
  }
  print ($found ? "PASS" : "FAIL") . " emails=" . count($ids) . " recips=[" . implode("|", $seen) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
