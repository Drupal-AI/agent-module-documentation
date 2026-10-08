#!/usr/bin/env bash
# Execution VERIFY: PASS when an English Terms & Conditions version with non-empty text exists
# in legal_conditions. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rows = \Drupal::database()->select("legal_conditions", "c")
    ->fields("c", ["conditions"])
    ->condition("language", "en")
    ->execute()->fetchCol();
  $ok = FALSE;
  foreach ($rows as $r) { if (trim(strip_tags((string) $r)) !== "") { $ok = TRUE; } }
  print (($ok) ? "PASS" : "FAIL") . " en_versions=" . count($rows) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
