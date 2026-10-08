#!/usr/bin/env bash
# Execution VERIFY: PASS when the target menu mm_mig_dst has at least one menu_link_content link
# (i.e. links were cloned from mm_mig_src). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $ids = $storage->getQuery()->accessCheck(FALSE)->condition("menu_name", "mm_mig_dst")->execute();
  $n = count($ids);
  print ($n >= 1 ? "PASS" : "FAIL") . " dst_links=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
