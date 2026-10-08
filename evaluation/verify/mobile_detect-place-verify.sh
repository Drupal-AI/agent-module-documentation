#!/usr/bin/env bash
# Execution VERIFY: PASS when a Mobile Detect Status block is placed with a device-type
# visibility condition that includes 'phone'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $ok = FALSE; $found = 0;
  foreach (Block::loadMultiple() as $b) {
    if ($b->get("plugin") !== "mobile_detect_status_block") { continue; }
    $found++;
    $vis = $b->get("visibility");
    $cond = $vis["mobile_detect_device_type"] ?? NULL;
    $devices = $cond["devices"] ?? [];
    if (in_array("phone", array_values($devices), TRUE)) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " status_blocks=$found\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
