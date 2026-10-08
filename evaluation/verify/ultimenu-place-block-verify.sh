#!/usr/bin/env bash
# Execution VERIFY: PASS when a block config entity exists whose plugin is the Ultimenu main
# derivative (ultimenu_block:ultimenu-main), placed in a real (non-Ultimenu) region. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = NULL;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "ultimenu_block:ultimenu-main") { $found = $b; break; }
  }
  if (!$found) { print "FAIL no ultimenu_block:ultimenu-main instance\n"; }
  else {
    $region = $found->getRegion();
    $ok = $region && strpos($region, "ultimenu") !== 0;
    print ($ok ? "PASS" : "FAIL") . " id=" . $found->id() . " region=" . $region . "\n";
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
