#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled search_api_sorts_field exists with
# display_id='sapisorts_display' and field_identifier='title'. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\search_api_sorts\Entity\SearchApiSortsField;
  $ok=FALSE;
  foreach (SearchApiSortsField::loadMultiple() as $e) {
    if ($e->getDisplayId()==="sapisorts_display" && $e->getFieldIdentifier()==="title" && $e->getStatus()==TRUE) { $ok=TRUE; }
  }
  print ($ok?"PASS":"FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
