#!/usr/bin/env bash
# Execution VERIFY: PASS when booking is flatpickr_date with #enableTime true.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("dtf_wf_task2");
  $els = $w ? $w->getElementsDecoded() : [];
  $b = $els["booking"] ?? [];
  $t = $b["#enableTime"] ?? NULL;
  $ok = (($b["#type"] ?? "") === "flatpickr_date") && ($t === TRUE || $t === 1 || $t === "1" || $t === "true");
  print ($ok ? "PASS" : "FAIL") . " type=" . ($b["#type"] ?? "none") . " enableTime=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
