#!/usr/bin/env bash
# Execution VERIFY for "create an OAuth client credential for user 1 with
# client_id jwtccf_task_client". PASS iff
# jwt_oauth_ccf.client_repository->getClient('jwtccf_task_client') returns a
# ClientCredential with uid === 1. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $client = \Drupal::service("jwt_oauth_ccf.client_repository")->getClient("jwtccf_task_client");
  $ok = ($client instanceof \Drupal\jwt_oauth_ccf\ClientCredential) && $client->uid === 1;
  print ($ok ? "PASS" : "FAIL") . " uid=" . var_export($client->uid ?? NULL, TRUE) . " clientId=" . var_export($client->clientId ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
