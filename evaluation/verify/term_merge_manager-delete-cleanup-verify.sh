#!/usr/bin/env bash
# Execution VERIFY: PASS when there are NO term_merge_into and NO term_merge_from rules left for
# vocabulary tmm_del (i.e. the target term "Obsolete" was deleted and the module's
# hook_taxonomy_term_delete cleaned up its merge rules). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $into = \Drupal::entityQuery("term_merge_into")->condition("vid","tmm_del")->accessCheck(FALSE)->count()->execute();
  $from = \Drupal::entityQuery("term_merge_from")->condition("vid","tmm_del")->accessCheck(FALSE)->count()->execute();
  $ok = ((int)$into === 0 && (int)$from === 0);
  print ($ok ? "PASS" : "FAIL") . " into=" . $into . " from=" . $from . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
