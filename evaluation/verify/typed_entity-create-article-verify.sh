#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one published-or-not node of bundle 'article' titled
# 'TE Article Probe' exists. Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("type","article")->condition("title","TE Article Probe")->execute();
  $ok = count($ids) > 0;
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
