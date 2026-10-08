#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'price' sort for display 'sapisorts_display3' has
# default_sort===TRUE. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  $ok=FALSE; $ds="none";
  foreach (SearchApiSortsField::loadMultiple() as $e) {
    if ($e->getDisplayId()==="sapisorts_display3" && $e->getFieldIdentifier()==="price") {
      $ds=var_export($e->getDefaultSort(),TRUE);
      if ($e->getDefaultSort()==TRUE && $e->getStatus()==TRUE) { $ok=TRUE; }
    }
  }
  print ($ok?"PASS":"FAIL")." default_sort=$ds\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
