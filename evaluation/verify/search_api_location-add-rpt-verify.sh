#!/usr/bin/env bash
# Execution VERIFY: PASS when index sal_test_index has at least one field of data type 'rpt'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api\Entity\Index;
  $i = Index::load("sal_test_index");
  $has = FALSE; $ids = [];
  if ($i) { foreach ($i->getFields() as $id=>$f) { if ($f->getType()==="rpt") { $has = TRUE; $ids[] = $id; } } }
  print ($has ? "PASS" : "FAIL") . " rpt_fields=" . implode(",", $ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
