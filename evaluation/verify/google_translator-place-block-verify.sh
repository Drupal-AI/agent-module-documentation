#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one enabled block config entity uses plugin google_translator.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  $found = "none"; $status = FALSE;
  foreach ($storage->loadMultiple() as $b) {
    if ($b->getPluginId() === "google_translator") { $found = $b->id(); $status = $b->status(); break; }
  }
  $ok = ($found !== "none" && $status);
  print ($ok ? "PASS" : "FAIL") . " block=" . $found . " enabled=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
