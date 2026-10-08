#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for domain.
# Checks the agent created a `domain` config entity for hostname shop.eval.example.com
# AND made it the site's default domain (is_default = TRUE). Both must hold to PASS.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("domain");
  $exists = FALSE; $isDefault = FALSE; $id = "";
  foreach ($s->loadMultiple() as $d) {
    if (strtolower($d->getHostname()) === "shop.eval.example.com") {
      $exists = TRUE; $id = $d->id(); $isDefault = (bool) $d->isDefault();
    }
  }
  $ok = ($exists && $isDefault);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0) . " default=" . ($isDefault?1:0) . " id=" . $id . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
