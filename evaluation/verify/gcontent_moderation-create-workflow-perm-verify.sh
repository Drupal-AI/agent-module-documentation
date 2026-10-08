#!/usr/bin/env bash
# Execution VERIFY: PASS when gcontent_moderation exposes the group permission
# 'use gcmod_task transition publish'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $perms = (new \Drupal\gcontent_moderation\Access\GroupContentModerationPermissions())->groupPermissions();
  $ok = array_key_exists("use gcmod_task transition publish", $perms);
  print ($ok ? "PASS" : "FAIL") . " total_perms=" . count($perms) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
