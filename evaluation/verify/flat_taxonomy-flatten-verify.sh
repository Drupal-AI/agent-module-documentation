#!/usr/bin/env bash
# Execution VERIFY: PASS when NO term in flattax_tree has a non-zero parent (the vocabulary was
# flattened). Requires at least the 2 terms to still exist.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $terms = $storage->loadByProperties(["vid"=>"flattax_tree"]);
  if (count($terms) < 2) { print "FAIL too-few-terms=".count($terms)."\n"; return; }
  $nested = 0;
  foreach ($terms as $t) { if (!empty($t->get("parent")->target_id)) { $nested++; } }
  print (($nested === 0) ? "PASS" : "FAIL")." terms=".count($terms)." nested=".$nested."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
