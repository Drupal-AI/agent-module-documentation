#!/usr/bin/env bash
# Execution VERIFY: PASS when a block mlist_task using the mailing_list_subscribe plugin exists and
# its settings.mailing_list == promo@lists.example.com. Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal\block\Entity\Block::load("mlist_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $list = $b ? ($b->get("settings")["mailing_list"] ?? "") : "";
  $ok = ($b && $plugin === "mailing_list_subscribe" && $list === "promo@lists.example.com");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " list=" . $list . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
