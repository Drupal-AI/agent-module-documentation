#!/usr/bin/env bash
# Execution VERIFY: PASS when vocabulary tmt_del exists and has 0 terms remaining.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  $v = Vocabulary::load("tmt_del");
  if (!$v) { print "FAIL vocab_missing\n"; return; }
  $n = \Drupal::entityTypeManager()->getStorage("taxonomy_term")->getQuery()
    ->accessCheck(FALSE)->condition("vid", "tmt_del")->count()->execute();
  print (($n == 0) ? "PASS" : "FAIL") . " remaining_terms=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
