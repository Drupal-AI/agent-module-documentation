#!/usr/bin/env bash
# Execution VERIFY: PASS when msqrole.settings tags_to_invalidate contains the cache tag
# 'config:block.block.sidebar'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("msqrole.settings")->get("tags_to_invalidate");
  $ok = (strpos($v, "config:block.block.sidebar") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " tags_to_invalidate=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
