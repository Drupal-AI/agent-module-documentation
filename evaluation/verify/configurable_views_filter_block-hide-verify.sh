#!/usr/bin/env bash
# Execution VERIFY: PASS when block 'cvfb_hide' has BOTH no_sort=TRUE and no_reset=TRUE in its
# settings. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("cvfb_hide");
  $s = $b ? $b->get("settings") : [];
  $ns = !empty($s["no_sort"]); $nr = !empty($s["no_reset"]);
  $ok = $ns && $nr;
  print ($ok ? "PASS" : "FAIL") . " no_sort=" . var_export($ns, TRUE) . " no_reset=" . var_export($nr, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
