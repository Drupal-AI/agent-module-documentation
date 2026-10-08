#!/usr/bin/env bash
# Execution VERIFY: PASS when acceptance is required on every login AND the administrator role
# is exempt from the T&C requirement. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("legal.settings");
  $every = $c->get("accept_every_login");
  $roles = $c->get("except_roles") ?: [];
  $ok = ($every === TRUE) && in_array("administrator", $roles, TRUE);
  print (($ok) ? "PASS" : "FAIL") . " accept_every_login=" . var_export($every, TRUE) . " except_roles=" . implode(",", $roles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
