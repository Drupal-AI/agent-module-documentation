#!/usr/bin/env bash
# Execution VERIFY: PASS when block mlist_side uses mailing_list_subscribe, is in the "sidebar"
# region, and targets news@lists.example.com. Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal\block\Entity\Block::load("mlist_side");
  $plugin = $b ? $b->getPluginId() : "none";
  $region = $b ? $b->getRegion() : "none";
  $list = $b ? ($b->get("settings")["mailing_list"] ?? "") : "";
  $ok = ($b && $plugin === "mailing_list_subscribe" && $region === "sidebar" && $list === "news@lists.example.com");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " region=" . $region . " list=" . $list . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
