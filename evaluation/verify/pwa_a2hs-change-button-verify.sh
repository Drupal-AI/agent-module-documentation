#!/usr/bin/env bash
# Execution VERIFY: PASS when block pwa_a2hs_switch button_text === 'Add to phone'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("pwa_a2hs_switch");
  $bt = $b ? ($b->get("settings")["button_text"] ?? NULL) : NULL;
  print (($bt === "Add to phone") ? "PASS" : "FAIL") . " button_text=" . var_export($bt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
