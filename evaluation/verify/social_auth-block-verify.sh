#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one enabled block with plugin social_auth_login is
# placed in some theme/region. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::entityTypeManager()->getStorage("block")->loadByProperties(["plugin" => "social_auth_login"]);
  $enabled = array_filter($blocks, fn($b) => $b->status());
  $ok = count($enabled) > 0;
  $desc = "";
  foreach ($enabled as $b) { $desc .= $b->id() . "@" . $b->getTheme() . ":" . $b->getRegion() . " "; }
  print ($ok ? "PASS" : "FAIL") . " count=" . count($enabled) . " " . $desc . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
