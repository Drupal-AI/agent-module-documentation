#!/usr/bin/env bash
# Execution VERIFY: PASS when the CKEditor 5 toolbar of format nbsp_tb contains the nbsp item.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal\editor\Entity\Editor::load("nbsp_tb");
  $items = $e ? ($e->getSettings()["toolbar"]["items"] ?? []) : [];
  $ok = in_array("nbsp", $items, TRUE);
  print ($ok ? "PASS" : "FAIL") . " toolbar=" . implode(",", $items) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
