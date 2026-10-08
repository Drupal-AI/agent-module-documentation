#!/usr/bin/env bash
# Execution VERIFY: PASS when a block with plugin 'dubbot_report' exists (id dubbot_report_task)
# with link_color '#ff0000'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal\block\Entity\Block::load("dubbot_report_task");
  $plugin = $b ? $b->get("plugin") : "none";
  $color = $b ? ($b->get("settings")["link_color"] ?? "") : "";
  $ok = ($plugin === "dubbot_report") && (strtolower($color) === "#ff0000");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " color=" . $color . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
