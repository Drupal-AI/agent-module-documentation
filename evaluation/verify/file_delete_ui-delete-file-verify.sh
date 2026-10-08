#!/usr/bin/env bash
# Execution VERIFY: PASS when NO managed file entity named fdu_eval_target.txt remains (the
# agent deleted it). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("file")->getQuery()
    ->accessCheck(FALSE)->condition("filename", "fdu_eval_target.txt")->execute();
  print (empty($ids) ? "PASS" : "FAIL count=" . count($ids)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
