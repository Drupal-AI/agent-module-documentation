#!/usr/bin/env bash
# Execution VERIFY: PASS when a block with id dth_userreg_task exists using the
# dxpr_theme_helper_user_register plugin. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("dth_userreg_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $ok = ($plugin === "dxpr_theme_helper_user_register");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
