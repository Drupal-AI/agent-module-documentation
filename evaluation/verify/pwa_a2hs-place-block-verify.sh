#!/usr/bin/env bash
# Execution VERIFY: PASS when block pwa_a2hs_task exists, plugin pwa_add_to_home_screen,
# button_text 'Install now'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("pwa_a2hs_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $bt = $b ? ($b->get("settings")["button_text"] ?? NULL) : NULL;
  $ok = ($b && $plugin === "pwa_add_to_home_screen" && $bt === "Install now");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " button_text=" . var_export($bt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
