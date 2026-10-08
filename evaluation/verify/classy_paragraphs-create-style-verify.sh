#!/usr/bin/env bash
# Live-state verification for the "create a Callout classy_paragraphs_style" task.
# PASS if an enabled classy_paragraphs_style config entity exists whose classes include
# BOTH `text-center` and `lead` (one per line). Exit 0 = pass, 1 = fail. No arguments.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $hitId = "";
  foreach (\Drupal::entityTypeManager()->getStorage("classy_paragraphs_style")->loadMultiple() as $s) {
    if (!$s->status()) { continue; }
    $lines = preg_split("/[\r\n]+/", (string) $s->getClasses(), -1, PREG_SPLIT_NO_EMPTY);
    if (in_array("text-center", $lines, TRUE) && in_array("lead", $lines, TRUE)) { $ok = TRUE; $hitId = $s->id(); }
  }
  print ($ok ? "PASS" : "FAIL") . " id=" . ($hitId ?: "-") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
