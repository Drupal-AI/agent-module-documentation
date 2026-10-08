#!/usr/bin/env bash
# Execution VERIFY: PASS when block blocache_task has a blocache override (overridden === TRUE) whose
# max-age is 0 (non-cacheable). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("blocache_task");
  $ov = $b ? $b->getThirdPartySetting("blocache", "overridden") : NULL;
  $md = $b ? $b->getThirdPartySetting("blocache", "metadata") : NULL;
  $ma = is_array($md) ? ($md["max-age"] ?? NULL) : NULL;
  $ok = ($ov === TRUE) && ((int) $ma === 0) && ($ma !== NULL);
  print ($ok ? "PASS" : "FAIL")." overridden=".var_export($ov, TRUE)." max-age=".var_export($ma, TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
