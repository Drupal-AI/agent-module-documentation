#!/usr/bin/env bash
# Execution VERIFY: PASS when the /lna-fix-source alias is stored with langcode 'und'.
# Reads the DB directly. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rows = \Drupal::database()->select("path_alias", "pa")
    ->fields("pa", ["langcode"])
    ->condition("path", "/lna-fix-source")
    ->execute()->fetchAll();
  $ok = FALSE; $info = "missing";
  if ($rows) {
    $lc = $rows[0]->langcode;
    $ok = ($lc === "und");
    $info = "langcode=" . $lc;
  }
  print ($ok ? "PASS" : "FAIL") . " " . $info . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
