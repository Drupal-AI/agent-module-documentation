#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled block placement exists in the default theme for the
# plugin views_exposed_filter_block:vbfb_place-block_1 and it is assigned to a region.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $theme = \Drupal::config("system.theme")->get("default");
  $found = NULL;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "views_exposed_filter_block:vbfb_place-block_1") { $found = $b; break; }
  }
  $region = $found ? (string) $found->getRegion() : "";
  $ok = $found && $found->status() && $found->getTheme() === $theme && $region !== "" && $region !== "none";
  print ($ok ? "PASS" : "FAIL") . " block=" . ($found ? $found->id() : "none")
    . " theme=" . ($found ? $found->getTheme() : "-") . " region=" . ($region ?: "-")
    . " status=" . var_export($found ? $found->status() : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
