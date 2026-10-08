#!/usr/bin/env bash
# Execution VERIFY: PASS when node 'VUA Del Node' still exists but has NO row left in the
# views_url_alias mapping table (its alias was removed). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("node")->condition("title","VUA Del Node")->accessCheck(FALSE)->execute();
  $id = $ids ? reset($ids) : 0;
  $cnt = $id ? (int) \Drupal::database()->select("views_url_alias","v")->condition("entity_type","node")
    ->condition("entity_id",$id)->countQuery()->execute()->fetchField() : -1;
  $ok = ($id > 0 && $cnt === 0);
  print ($ok ? "PASS" : "FAIL") . " node=$id rows=$cnt\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
