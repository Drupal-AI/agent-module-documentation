#!/usr/bin/env bash
# Execution VERIFY: PASS when block.block.cf_range_task exists with plugin copyright_footer
# and settings.year_origin == 2005. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("cf_range_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $yo = $b ? ($b->get("settings")["year_origin"] ?? "") : "";
  $ok = ($b && $plugin === "copyright_footer" && (string) $yo === "2005");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " year_origin=" . var_export($yo, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
