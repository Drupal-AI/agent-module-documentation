#!/usr/bin/env bash
# Execution VERIFY for "revoke/delete the jwtccf_del_client OAuth client
# credential". PASS iff
# jwt_oauth_ccf.client_repository->getClient('jwtccf_del_client') === NULL.
# Prints PASS/FAIL; exit 0 pass / 1 fail (fails on the reset state, where the
# credential still exists).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $client = \Drupal::service("jwt_oauth_ccf.client_repository")->getClient("jwtccf_del_client");
  $ok = ($client === NULL);
  print ($ok ? "PASS" : "FAIL") . " client=" . var_export($client, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
