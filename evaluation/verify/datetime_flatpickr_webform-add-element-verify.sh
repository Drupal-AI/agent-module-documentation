#!/usr/bin/env bash
# Execution VERIFY: PASS when webform dtf_wf_task has an element 'event_date' of type flatpickr_date.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("dtf_wf_task");
  $els = $w ? $w->getElementsDecoded() : [];
  $t = $els["event_date"]["#type"] ?? NULL;
  $ok = ($t === "flatpickr_date");
  print ($ok ? "PASS" : "FAIL") . " event_date_type=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
