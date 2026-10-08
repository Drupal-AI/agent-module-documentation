#!/usr/bin/env bash
# Execution VERIFY: PASS when SHA-256 is enabled in config AND the file_managed.sha256 column
# exists (proving hashing is actually wired up). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $on = (bool) (\Drupal::config("filehash.settings")->get("algorithms")["sha256"] ?? FALSE);
  $col = \Drupal::database()->schema()->fieldExists("file_managed", "sha256");
  $ok = $on && $col;
  print (($ok) ? "PASS" : "FAIL") . " enabled=" . var_export($on, TRUE) . " column=" . var_export($col, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
