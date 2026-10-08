#!/usr/bin/env bash
# Introspection SETUP: create a known OAuth client credential for uid 1 with
# client_id "jwtccf_eval_client" via jwt_oauth_ccf.client_repository, so an
# inspecting agent can read back its label/id. Idempotent (deletes any
# previous copy first so re-running doesn't throw on a duplicate id). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $repo = \Drupal::service("jwt_oauth_ccf.client_repository");
  $repo->deleteClient("jwtccf_eval_client");
  $repo->createClient(1, "jwtccf_eval", NULL, "jwtccf_eval_client");
' >/dev/null 2>&1
echo "setup: uid 1 has OAuth client jwtccf_eval_client (label jwtccf_eval)"
