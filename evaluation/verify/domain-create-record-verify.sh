#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for domain.
# Checks the agent created a `domain` config entity for hostname news.eval.example.com.
# PASS when such a domain entity exists live (any eval id); prints its id/name.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  $found = FALSE; $id = ""; $name = "";
  foreach ($s->loadMultiple() as $d) {
    if (strtolower($d->getHostname()) === "news.eval.example.com") {
      $found = TRUE; $id = $d->id(); $name = $d->label();
    }
  }
  print ($found ? "PASS" : "FAIL") . " host=news.eval.example.com id=" . $id . " name=\"" . $name . "\"\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
