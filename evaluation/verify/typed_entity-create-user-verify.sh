#!/usr/bin/env bash
# Execution VERIFY: PASS when a user account with email te_probe_user@example.com exists.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $uids=\Drupal::entityQuery("user")->accessCheck(FALSE)->condition("mail","te_probe_user@example.com")->execute();
  $ok=count($uids)>0;
  print ($ok?"PASS":"FAIL")." matches=".count($uids)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
