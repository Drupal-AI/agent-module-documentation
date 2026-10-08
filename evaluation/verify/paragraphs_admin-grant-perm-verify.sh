#!/usr/bin/env bash
# Execution VERIFY: PASS when role paragraphs_admin_editor holds the paragraphs_admin
# 'administer paragraphs' permission. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("paragraphs_admin_editor");
  $ok = $r && $r->hasPermission("administer paragraphs");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "exists" : "missing") . " has=" . var_export($r ? $r->hasPermission("administer paragraphs") : NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
