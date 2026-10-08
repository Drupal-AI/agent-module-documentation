#!/usr/bin/env bash
# Live-state verification for "grant access revision field to the content_editor role".
# PASS (exit 0) when the content_editor role holds the `access revision field` permission.
# Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE;
  $r = \Drupal::entityTypeManager()->getStorage("user_role")->load("content_editor");
  if ($r && $r->hasPermission("access revision field")) { $ok = TRUE; }
  print ($ok ? "PASS" : "FAIL") . " content_editor_has_perm=" . ($ok?1:0) . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL)")

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
