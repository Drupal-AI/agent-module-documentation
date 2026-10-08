#!/usr/bin/env bash
# Execution VERIFY: PASS when a block 'adsense_oc_eval_ad' exists using the adsense_oldcode_ad_block
# plugin with ad_channel 'oceval'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("adsense_oc_eval_ad");
  $plugin = $b ? $b->getPluginId() : "none";
  $chan = $b ? ($b->get("settings")["ad_channel"] ?? NULL) : NULL;
  $ok = $b && $plugin === "adsense_oldcode_ad_block" && (string) $chan === "oceval";
  print (($ok) ? "PASS" : "FAIL") . " plugin=" . $plugin . " ad_channel=" . var_export($chan, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
