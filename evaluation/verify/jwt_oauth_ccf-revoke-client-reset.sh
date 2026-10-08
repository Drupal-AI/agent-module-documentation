#!/usr/bin/env bash
# Execution RESET: ensure OAuth client "jwtccf_del_client" EXISTS for uid 1 (so
# verify FAILS until the agent deletes it). Idempotent (deletes any previous
# copy first so re-running doesn't throw on a duplicate id). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("jwt_oauth_ccf.client_repository");
  $repo->deleteClient("jwtccf_del_client");
  $repo->createClient(1, "jwtccf_del", NULL, "jwtccf_del_client");
' >/dev/null 2>&1
echo "reset: jwtccf_del_client present for uid 1"
