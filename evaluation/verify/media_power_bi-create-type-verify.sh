#!/usr/bin/env bash
# Execution VERIFY: PASS when a media type mpb_report exists that uses the Media Power BI source
# (media_power_bi). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mt = \Drupal\media\Entity\MediaType::load("mpb_report");
  $src = $mt ? $mt->getSource()->getPluginId() : "none";
  print (($src === "media_power_bi") ? "PASS" : "FAIL") . " media_type=" . ($mt ? "mpb_report" : "missing") . " source=" . $src . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
