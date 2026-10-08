#!/usr/bin/env bash
# Execution VERIFY: PASS when the storage entity of type rhs_hide has rh_action=page_not_found.
# Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_hide")->execute();
  $act = "none";
  foreach ($ids as $id) { $act = $s->load($id)->get("rh_action")->value; break; }
  $ok = ($act === "page_not_found");
  print ($ok ? "PASS" : "FAIL") . " rh_action=" . var_export($act, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
