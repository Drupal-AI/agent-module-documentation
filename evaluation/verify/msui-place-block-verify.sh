#!/usr/bin/env bash
# Execution VERIFY (message_subscribe_ui): PASS when at least one ENABLED block uses the
# message_subscribe_ui_block plugin (the "Manage subscriptions" block is placed). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = NULL;
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "message_subscribe_ui_block" && $b->status()) { $found = $b->id()."@".$b->getTheme().":".$b->getRegion(); break; }
  }
  print ($found ? "PASS placement=".$found : "FAIL placement=none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
