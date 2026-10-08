#!/usr/bin/env bash
# Live-state verification for "place the Events Feed (events_block) block".
# PASS when an enabled block config entity using plugin events_block exists in a real
# (non-disabled) region of the default theme. Exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = "none";
  $default = \Drupal::config("system.theme")->get("default");
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "events_block" && $b->status()
        && $b->getTheme() === $default && $b->getRegion() && $b->getRegion() !== "-1") {
      $ok = TRUE; $detail = $b->id() . "@" . $b->getRegion() . "/" . $b->getTheme();
    }
  }
  print ($ok ? "PASS" : "FAIL") . " block=" . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
