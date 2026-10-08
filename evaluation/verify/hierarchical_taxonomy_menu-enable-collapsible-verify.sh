#!/usr/bin/env bash
# Execution VERIFY: PASS when block htm_task has collapsible == TRUE. Prints PASS/FAIL.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("htm_task");
  if (!$b) { print "FAIL no-block\n"; return; }
  $v = $b->get("settings")["collapsible"] ?? NULL;
  $ok = ((bool)$v === TRUE);
  print ($ok?"PASS":"FAIL")." collapsible=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
