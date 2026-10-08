#!/usr/bin/env bash
# Execution VERIFY: PASS when no block_content entity of type ebt_rhtask remains. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("block_content")->accessCheck(FALSE)->condition("type","ebt_rhtask")->execute();
  print (count($ids) === 0 ? "PASS" : "FAIL") . " ebt_rhtask_blocks=" . count($ids);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
