#!/usr/bin/env bash
# Execution VERIFY: PASS when a block 'adsense_eval_ad' exists using the adsense_managed_ad_block
# plugin with ad_slot '1234567890'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("adsense_eval_ad");
  $plugin = $b ? $b->getPluginId() : "none";
  $slot = $b ? ($b->get("settings")["ad_slot"] ?? NULL) : NULL;
  $ok = $b && $plugin === "adsense_managed_ad_block" && (string) $slot === "1234567890";
  print (($ok) ? "PASS" : "FAIL") . " plugin=" . $plugin . " ad_slot=" . var_export($slot, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
